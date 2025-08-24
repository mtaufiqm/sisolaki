import 'package:bpssulsel/helper/hash_crypt_helper.dart';
import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String username,
) async {
  return switch(context.request.method) {
    HttpMethod.post => onPost(context,username),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onPost(RequestContext ctx, String username) async {
  UserRepository userRepo = ctx.read<UserRepository>();
  User authUser = ctx.read<User>();

  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || (authUser.username == username))){
      return RespHelper.forbidden();
    }
    User user = await userRepo.getById(username);
    String password = "bpssulsel_7300";   //reset password
    String hashedPwd = HashCryptHelper.hashPassword(password);
    await userRepo.updatePasswordOnly(username, hashedPwd);
    return RespHelper.message(message: "SUCCESS");
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured");
  }
}

