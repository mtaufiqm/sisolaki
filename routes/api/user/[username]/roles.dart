import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/roles.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/user_repository.dart';

import '../../eom_candidate/item/[uuid]/index.dart';

Future<Response> onRequest(RequestContext context,String username) async {
  return switch(context.request.method){
    HttpMethod.get => onGet(context,username),
    HttpMethod.post => onPost(context, username),
    HttpMethod.delete => onDelete(context, username),
    _ => Future.value(RespHelper.message(statusCode: HttpStatus.methodNotAllowed,message: "Method Not Allowed"))
  };
}

Future<Response> onGet(RequestContext context,String username) async {
  User user = context.read<User>();
  UserRepository userRepository = context.read<UserRepository>();
  if(!((user.username == username) || (user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG","GET_ROLES"])))){
    return RespHelper.message(statusCode: HttpStatus.unauthorized,message: "Your Are Not Allowed");
  } 
  List<Roles> roles = await userRepository.getRolesByUserId(username);
  return Response.json(body:{
    "roles":roles
  });
}

Future<Response> onPost(RequestContext context,String username) async {
  var jsonBody = context.request.json() as Map<String,dynamic>;
  List<String> rolesBody = (jsonBody["roles"] as List).cast<String>();
  User user = context.read<User>();
  UserRepository userRepository = context.read<UserRepository>();

  //If not contain one of this roles, or set own roles will be fails;
  if(!(user.isContainOne(["ADMIN","SUPERADMIN","KEPALA","KASUBBAG","POST_ROLES"])) || user.username == username){
    return RespHelper.message(statusCode: HttpStatus.unauthorized,message: "Your Are Not Allowed");
  } 

  //Target User
  User targetUser = User(username: username,is_active: true);

  //roles of authenticated user  
  List<Roles> roles = await userRepository.getRolesByUserId(username);

  //if user that want to set contains superadmin, you cant set it,
  if(roles.contains("SUPERADMIN")){
    return RespHelper.message(statusCode: HttpStatus.unauthorized,message: "You Are Not Allowed set Roles of SUPERADMIN");
  }

  //ACTION : DELETE OLD USER ROLES
  await userRepository.deleteOldUserRoles(targetUser);


  //ADD : INSERT NEW ROLES FROM INPUT
  List<Roles> targetUserNewRoles = await userRepository.createUserRoles(targetUser, rolesBody.map((item) => Roles(description: item)).toList());

  return Response.json(body:{
    "roles":targetUserNewRoles
  });
}

Future<Response> onDelete(RequestContext ctx, String username) async {
  UserRepository userRepo = ctx.read<UserRepository>();
  User authUser = ctx.read<User>();
  try {
    if(!((authUser.isContainOne(["ADMIN","SUPERADMIN"])))){
      return RespHelper.forbidden();
    }
    await userRepo.deleteOldUserRoles(User(username: username, is_active: true));
    return RespHelper.message(message: "Success");
  } catch (err){
    return RespHelper.badRequest(message: "Error Occured ${err}");
  }
}