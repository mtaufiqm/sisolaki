import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_penilaian.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return (switch(context.request.method){
    HttpMethod.post => onPost(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}


Future<Response> onPost(RequestContext ctx, String uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();


  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.unauthorized();
  }
  //AUTHORIZATION


  try {
    EomPenilaian penilaian = await eomPenilaianRepo.getByUuid(uuid);
    if(penilaian.status > 0){
      return RespHelper.badRequest(message: "Already Started");
    }
    EomPenilaian startedPenilaian = await eomPenilaianRepo.start(penilaian.uuid!);
    return Response.json(body: startedPenilaian);    
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
}