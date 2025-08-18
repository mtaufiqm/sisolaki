import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
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
//get all vote for this penilaian based on uuid
Future<Response> onGet(RequestContext ctx, String uuid) async {
  EomVoteRepository voteRepo = ctx.read<EomVoteRepository>();
  User authUser = ctx.read<User>();

  try {
    return Response.json(body: await voteRepo.readDetailsByPenilaian(uuid));
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
  
}
