import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
  String username,
) async {
  return (switch(context.request.method){
    HttpMethod.get => onGet(context,uuid,username),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}

Future<Response> onGet(RequestContext ctx, String uuid, String username) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  EomCandidateRepository eomCandidateRepo = ctx.read<EomCandidateRepository>();
  EomPenilaian360Repository eomp360Repo = ctx.read<EomPenilaian360Repository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();


  try { 

    //AUTHORIZATION
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || authUser.username == username)){
      return RespHelper.forbidden();
    }
    var listObject = await eomp360Repo.readDetailsByPenilaianAndVoterUsername(uuid, username);
    //AUTHORIZATION

    
    return Response.json(body: listObject);
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured");
  }
}
