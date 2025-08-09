import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {

  return Response.json(body: {
    "message":"Selamat Datang di Web API SISOLAKI, your IP : ${context.request.connectionInfo.remoteAddress.address}"
  });
}
