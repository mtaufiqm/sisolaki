import 'dart:convert';

import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/tim_pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/tim_repository.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String uuid,
) async {
  return switch(context.request.method) {
    HttpMethod.get => onGet(context, uuid),
    HttpMethod.post => onPost(context, uuid),
    HttpMethod.delete => onDelete(context,uuid),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}


Future<Response> onGet(RequestContext context, String uuid) async {
  User user = context.read<User>();
  UserRepository userRepository = context.read<UserRepository>();
  TimRepository timRepository = context.read<TimRepository>();

  //If not contain one of this roles, or set own roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  try {
    List<TimPegawai> listTim = await timRepository.getTimByPegawaiUuid(uuid);
    return Response.json(body: listTim);
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}

//this will update tim for certain pegawai
Future<Response> onPost(RequestContext context, String uuid) async {
  User user = context.read<User>();
  UserRepository userRepository = context.read<UserRepository>();
  TimRepository timRepository = context.read<TimRepository>();

  //If not contain one of this roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  try {
    var jsonObject = await context.request.json();
    if(!(jsonObject is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    TimPegawaiDTO tim = TimPegawaiDTO.fromJson(jsonObject as Map<String,dynamic>);
    await timRepository.setTimForSpesificPegawai(tim);
    return RespHelper.message(message: "Success");
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}


//this will clear old tim for certain pegawai
Future<Response> onDelete(RequestContext context, String uuid) async {
  User user = context.read<User>();
  TimRepository timRepository = context.read<TimRepository>();

  //If not contain one of this roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG"]))){
    return RespHelper.forbidden();
  }
  try {
    await timRepository.clearTimForSpesificPegawai(uuid);
    return RespHelper.message(message: "Success");
  } catch(err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}


