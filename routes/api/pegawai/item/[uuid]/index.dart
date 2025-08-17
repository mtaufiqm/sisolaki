import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/tim_pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method) {
    HttpMethod.get => onGet(context, uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}


Future<Response> onGet(RequestContext context, String uuid) async {
  User user = context.read<User>();
  UserRepository userRepository = context.read<UserRepository>();
  TimRepository timRepository = context.read<TimRepository>();

  //If not contain one of this roles, or set own roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  try {
    return Response.json();
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}


