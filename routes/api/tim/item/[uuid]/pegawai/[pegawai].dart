import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
  String pegawai,
) async {
  // TODO: implement route handler
  return switch(context.request.method){
    HttpMethod.delete => onDelete(context,uuid,pegawai),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onDelete(RequestContext ctx, String uuid, String pegawai) async {
  TimRepository timRepo = ctx.read<TimRepository>();
  User authUser = ctx.read<User>();
  try {
    print("Clicked");
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    await timRepo.deleteSpesificPegawaiAndTim(pegawai, uuid);
    return RespHelper.message(message: "SUCCESS");
  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
