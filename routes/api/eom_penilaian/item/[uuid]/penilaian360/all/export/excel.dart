import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:excel/excel.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return (switch(context.request.method){
    HttpMethod.get => onGet(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}


Future<Response> onGet(RequestContext ctx, String uuid) async {
  EomPenilaian360Repository p360Repo = ctx.read<EomPenilaian360Repository>();
  TimRepository timRepo = ctx.read<TimRepository>();
  User authUser = ctx.read<User>();
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  try {
    List<EomPenilaian360Grouped> listObject = await p360Repo.readByPenilaianGroupByVoter(uuid);
    Map<String,PegawaiWithTim> mapPegawai = {};
    for(var item in listObject){
        PegawaiWithTim pegawai = PegawaiWithTim.fromJson(item.object);
        var listTim = await timRepo.getTimByPegawaiUuid(pegawai.uuid!);
        if(!listTim.isEmpty){
          pegawai.tim = listTim.first.tim;
        }
        mapPegawai[pegawai.uuid!] = pegawai;
        continue;
    }
    Excel excel = Excel.createExcel();
    Sheet firstSheet = excel.sheets.values.first;
    //createHeader
    firstSheet.appendRow([
      TextCellValue("Username"),
      TextCellValue("Nama"),
      TextCellValue("NIP"),
      TextCellValue("Tim"),
      TextCellValue("Diisi"),
      TextCellValue("Total"),
      TextCellValue("Status")
    ]);
    for(var item in listObject){
      int total = item.penilaian360.length;
      int complete = 0;
      bool is_done = false;
      if(total != 0){
        item.penilaian360.forEach((el){
          if(el.is_complete){
            complete++;
          }
        });
      } else {
        is_done = true;
      }
      if(complete >= total){
        is_done = true;
      }
      Pegawai pegawaiItem = Pegawai.fromJson(item.object);
      firstSheet.appendRow([
        TextCellValue("${pegawaiItem.username}"),
        TextCellValue("${pegawaiItem.fullname_with_title}"),
        TextCellValue("${pegawaiItem.nip}"),
        TextCellValue("${mapPegawai[pegawaiItem.uuid!]?.tim?.title??'?'}"),
        TextCellValue("${complete}"),
        TextCellValue("${total}"),
        TextCellValue("${is_done?'SELESAI':'BELUM SELESAI'}")
      ]);
    }
    return Response.bytes(headers: {
      "Content-Type":"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": "attachment; filename=\"Penilaian360SISOLAKI.xlsx\""
    },body: excel.save(fileName: "ExportFile.xlsx"));
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}
