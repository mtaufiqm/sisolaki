import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_vote.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:excel/excel.dart';

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
  EomVoteRepository voteRepo = ctx.read<EomVoteRepository>();
  EomCandidateRepository candidateRepo = ctx.read<EomCandidateRepository>();
  TimRepository timRepo = ctx.read<TimRepository>();
  User authUser = ctx.read<User>();

  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    List<EomVoteDetails> vote = await voteRepo.readDetailsByPenilaian(uuid);
    Map<String,PegawaiWithTim> mapPegawaiDetails = {};
    for(var item in vote){
      var tim = await timRepo.getTimByPegawaiUuid(item.voter!.uuid!);
      PegawaiWithTim pwt = PegawaiWithTim.fromJson(item.voter!.toJson());
      if(!tim.isEmpty){
        pwt.tim = tim.first.tim!;
      }
      mapPegawaiDetails[item.voter!.uuid!] = pwt;
    }
    Excel excel = Excel.createExcel();
    var firstSheet = excel.sheets.values.first;
    firstSheet.appendRow([
      TextCellValue("Username"),
      TextCellValue("Nama Pegawai"),
      TextCellValue("NIP"),
      TextCellValue("Tim"),
      TextCellValue("Status"),
      TextCellValue("Last Updated")
    ]);
    for(var item in vote){
      firstSheet.appendRow(
        [
          TextCellValue("${item.voter!.username!}"),
          TextCellValue("${item.voter!.fullname_with_title!}"),
          TextCellValue("${item.voter!.nip}"),
          TextCellValue("${mapPegawaiDetails[item.voter!.uuid!]?.tim?.title??'?'}"),
          TextCellValue("${item.is_complete?'SELESAI':'BELUM SELESAI'}"),
          TextCellValue("${item.last_updated}")
        ]
      );
    }
    return Response.bytes(headers: {
      "Content-Type":"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": "attachment; filename=\"VoteSISOLAKI.xlsx\""
    },body: excel.save(fileName: "ExportFile.xlsx"));
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
}
