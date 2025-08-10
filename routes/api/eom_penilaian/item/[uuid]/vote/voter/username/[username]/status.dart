import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
  String username,
) async {
  // TODO: implement route handler
  return (switch(context.request.method){
    HttpMethod.get => onGet(context,uuid,username),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}



Future<Response> onGet(RequestContext ctx, String uuid, String username) async {
  EomVoteRepository eomVoteRepo = ctx.read<EomVoteRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || authUser.username == username)){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    var isExists = await eomVoteRepo.isExistsByPenilaianAndVoterUsername(uuid, username);
    if(isExists){
      return Response.json(
        body: {
          "exists":true
        }
      );
    } else {
      return Response.json(
        body: {
          "exists":false
        }
      );
    }
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}