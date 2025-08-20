import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method){
    HttpMethod.get => onGet(context),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onGet(RequestContext context) async {
  UserRepository userRepo = context.read<UserRepository>();

  //AUTHORIZATION
  User user = context.read<User>();
  if(!user.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","GET_ALL_ROLE"])){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION
  //======================================================

  try {
    return Response.json(body: await userRepo.readAllRole());
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred");
  }
}
