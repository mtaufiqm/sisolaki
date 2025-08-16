import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
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
  return Response.json();
}

Future<Response> onDelete(RequestContext ctx, String uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  EomCandidateRepository eomCandidateRepo = ctx.read<EomCandidateRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  print("Delete Called");

  try {
    await eomCandidateRepo.delete(uuid);
    return RespHelper.message(message: "SUCCESS");
  } catch(err){
    print("Error Delete ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
