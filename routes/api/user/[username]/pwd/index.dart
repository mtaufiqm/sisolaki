import 'package:bpssulsel/helper/hash_crypt_helper.dart';
import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String username,
) async {
  return (switch(context.request.method){
    HttpMethod.post => onPost(context,username),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}

//this change password only
Future<Response> onPost(RequestContext ctx, String username) async {
  UserRepository userRepo = ctx.read<UserRepository>();
  User authUser = ctx.read<User>();

  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || (authUser.username == username))){
      return RespHelper.forbidden();
    }
    var jsonObject = await ctx.request.json();
    if(!(jsonObject is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    User inputUser = User.fromJson(jsonObject as Map<String,dynamic>);
    if(inputUser.pwd == null || inputUser.pwd!.trim().isEmpty){
      return RespHelper.badRequest(message: "Password Tidak Boleh Kosong");
    }
    if(inputUser.pwd!.trim().length < 6){
      return RespHelper.badRequest(message: "Password Terlalu Singkat");
    }
    String hashedPwd = HashCryptHelper.hashPassword(inputUser.pwd!.trim());
    await userRepo.updatePasswordOnly(username, hashedPwd);
    return RespHelper.message(message: "SUCCESS");
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured");
  }
}
