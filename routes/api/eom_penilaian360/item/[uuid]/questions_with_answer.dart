import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/penilaian360_answers_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method){
    HttpMethod.get => onGet(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onGet(RequestContext ctx, String uuid) async {

  EomPenilaian360Repository eop360Repo = ctx.read<EomPenilaian360Repository>();
  Penilaian360AnswersRepository eom360AnswerRepo = ctx.read<Penilaian360AnswersRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  try {

    EomPenilaian360Details object = await eop360Repo.getDetailsByUuid(uuid);

    //AUTHORIZATION
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || authUser.username == object.voter?.p_username)){
      return RespHelper.forbidden();
    }
    //AUTHORIZATION
    //AUTHORIZATION
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    //AUTHORIZATION
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
