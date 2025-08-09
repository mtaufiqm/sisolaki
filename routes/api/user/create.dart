import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:bpssulsel/helper/hash_crypt_helper.dart';
import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';


//CREATE USER
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method){
    HttpMethod.post => onPost(context),
    _ => Future.value(Response.json(statusCode: HttpStatus.methodNotAllowed))
  };
}



Future<Response> onPost(RequestContext context) async{
  //AUTHORIZATION
  User user = context.read<User>();
  if(!user.isContainOne(["SUPERADMIN","ADMIN","CREATE_USER"])){
    return Response.json(statusCode: HttpStatus.unauthorized,body: {"message":"You Have No Access For This"});
  }
  //AUTHORIZATION
  //======================================================

  var maps = ((await context.request.json()) as Map).cast<String,String>();
  String? username = maps["username"];
  String? password = maps["password"];
  if(username == null || password == null){
    return RespHelper.message(statusCode: HttpStatus.badRequest,message: "Username/Password Cannot be Blank!");
  }
  if((username.contains(" ") || username.length < 6) || (password.contains(" ") || password.length < 6)){
    return RespHelper.message(statusCode: HttpStatus.badRequest,message: "Username and Password Cant Contain Space and Minimum Character is 6!");
  }

  String hashedPass = HashCryptHelper.hashPassword(password);

  UserRepository userRepo = context.read<UserRepository>();
  try{
    await userRepo.create(User.fromJson({"username":username,"password":hashedPass,"is_active":true}));
  } catch(e){
    return RespHelper.message(statusCode: HttpStatus.badRequest,message: "Username already exists!");
  }
  return Response.json(statusCode: HttpStatus.ok,body: {"username":username});

}