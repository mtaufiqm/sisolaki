import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/report.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/report_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
) async {
  return switch(context.request.method){
    HttpMethod.get => onGet(context),
    HttpMethod.post => onPost(context),
    _ => Future.value(RespHelper.methodNotAllowed())
  };
}

Future<Response> onGet(RequestContext ctx) async {
  ReportRepository reportRepo = ctx.read<ReportRepository>();
  User authUser = ctx.read<User>();
  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    return Response.json(body: await reportRepo.readAll());
  } catch(err){
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
}

Future<Response> onPost(RequestContext ctx) async {
  User authUser = ctx.read<User>();
  ReportRepository reportRepo = ctx.read<ReportRepository>();
  try {
    print("Called");
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG","PEGAWAI"]))){
      return RespHelper.forbidden();
    }
    var jsonBody = await ctx.request.json();
    if(!(jsonBody is Map<String,dynamic>)){
      return RespHelper.badRequest(message: "Invalid JSON Body");
    }
    Report input = Report.fromJson(jsonBody as Map<String,dynamic>);
    return Response.json(body: await reportRepo.create(input));
  } catch(err){
    print("Error ${err}");
    return RespHelper.badRequest(message: "Error Occurred ${err}");
  }
}