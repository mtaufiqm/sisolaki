import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_candidate.dart';
import 'package:bpssulsel/models/eom/eom_vote.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
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
    HttpMethod.post => onPost(context,uuid,username),
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
    var object = await eomVoteRepo.getDetailsByPenilaianAndVoterUsername(uuid, username);
    return Response.json(
      body: object
    );
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}


//can be updated only if it still not completed
Future<Response> onPost(RequestContext ctx, String uuid, String username) async {
  EomVoteRepository eomVoteRepo = ctx.read<EomVoteRepository>();
  EomCandidateRepository eomCandidateRepo = ctx.read<EomCandidateRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();


  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]) || authUser.username == username)){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {

    var voteDetails = await eomVoteRepo.getDetailsByPenilaianAndVoterUsername(uuid,username);
    if(voteDetails.is_complete == true){
      return RespHelper.badRequest(message: "Already Completed");
    }

    var mapBody = await ctx.request.json();
    if(!(mapBody is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }

    EomVote updateVote = EomVote.fromJson(mapBody);
    updateVote.uuid = voteDetails.uuid!;
    updateVote.penilaian = voteDetails.penilaian;
    updateVote.voter = voteDetails.voter!.uuid!;
    updateVote.created_at = voteDetails.created_at;
    updateVote.last_updated = voteDetails.last_updated;
    updateVote.is_complete = true;

    if(updateVote.choice1 == null || updateVote.choice2 == null){
      return RespHelper.badRequest(message: "Pilihan Tidak Boleh Kosong!");
    }

    if(updateVote.choice1 == updateVote.choice2){
      return RespHelper.badRequest(message: "Pilihan Tidak Boleh Sama!");
    }


    List<String> listUuidCandidate = (await eomCandidateRepo.readDetailsByPenilaian(uuid)).map((el) => el.pegawai!.p_uuid!).toList();

    if(!(listUuidCandidate.contains(updateVote.choice1) && listUuidCandidate.contains(updateVote.choice2))){
      return RespHelper.badRequest(message: "Pilihan Tidak Terdapat Dalam Kandidat");
    }

    var updatedVote = await eomVoteRepo.update(updateVote.uuid!, updateVote);
    return Response.json(body: updatedVote);


  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}