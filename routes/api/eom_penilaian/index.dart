import 'dart:convert';
import 'dart:math';

import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/eom/eom_penilaian.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
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
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();

  bool isReturnAll = false;

  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  if(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"])) {
    isReturnAll = true;
  }

  try { 
    Pegawai pegawai = await pegawaiRepo.getByUsername(authUser.username);

    List<EomPenilaian> listOfObject = [];
    if(isReturnAll){
      listOfObject = await eomPenilaianRepo.readAll();
    } else {
      listOfObject = await eomPenilaianRepo.readByStatus(1);
    }
    return Response.json(body: listOfObject);
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured");
  }
}

Future<Response> onPost(RequestContext ctx) async {
  EomPenilaianRepository eomPenilaianRepo = ctx.read<EomPenilaianRepository>();
  PegawaiRepository pegawaiRepo = ctx.read<PegawaiRepository>();
  User authUser = ctx.read<User>();


  //AUTHORIZATION
  if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  //AUTHORIZATION

  try { 
    Pegawai pegawai = await pegawaiRepo.getByUsername(authUser.username);
    var jsonBody = await ctx.request.json();
    if(!(jsonBody is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }

    EomPenilaian eomPenilaian = EomPenilaian.fromJson(jsonBody);

    var result = await eomPenilaianRepo.create(eomPenilaian);
    return Response.json(body: result);
    
  } catch(e){
    print(e);
    return RespHelper.badRequest(message: "Error Occured");
  }
}
