import 'package:bpssulsel/helper/response_helper.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:dart_frog/dart_frog.dart';

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
  EomPenilaian360Repository e360Repo = ctx.read<EomPenilaian360Repository>();
  User authUser = ctx.read<User>();
  try {
    if(!(authUser.isContainOne(["SUPERADMIN","ADMIN","KEPALA","KASUBBAG"]))){
      return RespHelper.forbidden();
    }
    return Response.json(body: await e360Repo.readByPenilaianGroupByVoter(uuid));
  } catch(err){
    print(err);
    return RespHelper.badRequest(message: "Error Occurred");
  }
}
