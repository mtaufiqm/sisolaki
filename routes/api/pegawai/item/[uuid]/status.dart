import 'dart:convert';

import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method){
    HttpMethod.post => onPost(context, uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}


Future<Response> onPost(RequestContext ctx, String uuid) async {
  User authUser = ctx.read<User>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  print("Called");
  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    var jsonBody = await ctx.request.json();
    if(!(jsonBody is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    int status = jsonBody["status_pegawai"] as int;
    return Response.json(body: await pegawaiRepo.setStatusPegawaiByUuid(uuid, status));
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
}