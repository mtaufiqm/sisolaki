import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_penilaian.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  // TODO: implement route handler
  return (switch(context.request.method){
    HttpMethod.get => onGet(context,uuid),
    HttpMethod.post => onPost(context,uuid),
    HttpMethod.delete => onDelete(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  });
}

Future<Response> onGet(RequestContext ctx, String uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try { 
    Pegawai pegawai = await pegawaiRepo.getByUsername(authUser.username);

    var object = await eomPenilaianRepo.getByUuid(uuid);

    return Response.json(body: object);
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured");
  }
}

Future<Response> onPost(RequestContext ctx, String uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  bool isReturnAll = false;

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.unauthorized();
  }
  //AUTHORIZATION

  try { 
    Pegawai pegawai = await pegawaiRepo.getByUsername(authUser.username);

    var jsonBody = await ctx.request.json();

    if(!(jsonBody is Map<String,dynamic>)) {
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }

    
    List<EomPenilaian> listOfObject = [];
    
    return Response.json(body: listOfObject);
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured");
  }
}

Future<Response> onDelete(RequestContext ctx, String uuid) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN"]))){
    return RespHelper.unauthorized();
  }
  //AUTHORIZATION

  try { 
    await eomPenilaianRepo.delete(uuid);
    return Response.json(body: "SUCCESS");
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured ${e}");
  }
}

