import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_data.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_data_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method){
    HttpMethod.get => onGet(context,uuid),
    HttpMethod.post => onPost(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}


Future<Response> onGet(RequestContext ctx, String candidate_uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  EomCandidateRepository eomCandidateRepo = ctx.read<EomCandidateRepository>();
  EomDataRepository eomDataRepo = ctx.read<EomDataRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    return Response.json(body: await eomDataRepo.getByCandidateUuid(candidate_uuid));
  } catch(err){
    print("error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}

Future<Response> onPost(RequestContext ctx, String candidate_uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  EomCandidateRepository eomCandidateRepo = ctx.read<EomCandidateRepository>();
  EomDataRepository eomDataRepo = ctx.read<EomDataRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    var jsonObject = await ctx.request.json();
    if(!(jsonObject is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    EomData data = EomData.fromJson(jsonObject as Map<String,dynamic>);
    return Response.json(body: await eomDataRepo.updateByCandidateUuid(candidate_uuid, data));
  } catch(err){
    print("error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}