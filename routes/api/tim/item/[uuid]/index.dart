import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method) {
    HttpMethod.get => onGet(context,uuid),
    HttpMethod.delete => onDelete(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}


Future<Response> onGet(RequestContext ctx, String uuid) async {
  TimRepository timRepository = ctx.read<TimRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    return Response.json(body: await timRepository.getDetailsById(uuid));
  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}

Future<Response> onDelete(RequestContext ctx, String uuid) async {
  return Response.json();
}
