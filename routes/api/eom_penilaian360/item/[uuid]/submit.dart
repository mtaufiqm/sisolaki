import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_questions.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/penilaian360_answers_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/penilaian360_questions_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:bpssulsel/responses/penilaian360_submit_response.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method){
    HttpMethod.post => onPost(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onPost(RequestContext ctx, String uuid) async {

  EomPenilaian360Repository eop360Repo = ctx.read<EomPenilaian360Repository>();
  Penilaian360AnswersRepository eom360AnswerRepo = ctx.read<Penilaian360AnswersRepository>();
  Penilaian360QuestionsRepository eom360QuestionRepo = ctx.read<Penilaian360QuestionsRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  try {

    EomPenilaian360Details object = await eop360Repo.getDetailsByUuid(uuid);

    //AUTHORIZATION
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || authUser.username == object.voter?.p_username)){
      return RespHelper.forbidden();
    }
    //AUTHORIZATION

    //if this penilaian360 already answered, just return invalid response
    if(object.is_complete){
      return RespHelper.badRequest(message: "Already Answered");
    }
    var jsonInput = await ctx.request.json();
    if(!(jsonInput is List<dynamic>)) {
      return RespHelper.badRequest(message:"Invalid JSON Body");
    }
    List<Penilaian360Answers> listAnswer = [];
    for(var item in jsonInput){
      try {
        var object = Penilaian360Answers.fromJson(item as Map<String,dynamic>);
        listAnswer.add(object);
      } catch(er){
        continue;
      }
    }
    List<Penilaian360Answers> listResult = await eom360AnswerRepo.submitByPenilaian360Uuid(object.uuid!,listAnswer);
    EomPenilaian360 updatedDetails = await eop360Repo.getByUuid(object.uuid!);
    return Response.json(body: Penilaian360SubmitResponse(penilaian360: updatedDetails, answers: listResult));
  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
