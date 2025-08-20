import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/roles.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context,String username) async {
  return switch(context.request.method){
    HttpMethod.post => onPost(context, username),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onPost(RequestContext context, String username) async {
  UserRepository userRepo = context.read<UserRepository>();
  User authUser = context.read<User>();

  try {
    if(!((authUser.isContainOne(["ADMIN","SUPERADMIN"])))){
      return RespHelper.forbidden();
    }
    var jsonBody = await context.request.json();
    if(!(jsonBody is Map<String,dynamic>)){
      return RespHelper.forbidden();
    }
    Roles inputRoles = Roles.fromJson(jsonBody as Map<String,dynamic>);
    if(!authUser.isContain("SUPERADMIN") && (inputRoles.description == "SUPERADMIN")){
      return RespHelper.forbidden();
    }
    print(inputRoles.description);
    await userRepo.insertNewRoleForUser(username, inputRoles);
    return RespHelper.message(message: "SUCCESS");
  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occured");
  }
}