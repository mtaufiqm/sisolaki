import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: implement route handler
  return (switch(context.request.method){
    HttpMethod.get => onGet(context),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}


Future<Response> onGet(RequestContext ctx) async {
  User user = ctx.read<User>();
  UserRepository userRepository = ctx.read<UserRepository>();

  //If not contain one of this roles, or set own roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG","READ_USER"]))){
    return RespHelper.methodNotAllowed();
  } 

  try {
    var allUser = await userRepository.readAll();
    return Response.json(body: allUser);
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
