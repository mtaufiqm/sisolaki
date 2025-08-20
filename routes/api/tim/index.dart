import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: implement route handler
  return switch(context.request.method){
    HttpMethod.get => onGet(context),
    HttpMethod.post => onPost(context),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onGet(RequestContext ctx) async {
  TimRepository timRepository = ctx.read<TimRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    print("GET All Tim");
    return Response.json(body: await timRepository.readAll());
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}

Future<Response> onPost(RequestContext ctx) async {
  TimRepository timRepository = ctx.read<TimRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","INSERT_TIM"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try {
    var jsonBody = await ctx.request.json();
    if(!(jsonBody is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    Tim inputTim = Tim.fromJson(jsonBody as Map<String,dynamic>);

    return Response.json(body: await timRepository.create(inputTim));
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}