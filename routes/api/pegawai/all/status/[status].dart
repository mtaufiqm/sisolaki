import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String status) async {
  // TODO: implement route handler
  return (switch(context.request.method){
    HttpMethod.get => onGet(context,status),
    _ => Future.value(RespHelper.methodNotAllowed()) 
  });
}


Future<Response> onGet(RequestContext ctx, String status) async{
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();

  //AUTHORIZATION
  User user = ctx.read<User>();
  if(!(user.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try{
    int statusInt = int.tryParse(status)??0;
    List<Pegawai> list_object = await pegawaiRepo.readAllByStatus(statusInt);
    return Response.json(body: list_object);
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Fail To Get All Data");
  }
}