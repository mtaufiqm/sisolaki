import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

final JWTKey secretKey = SecretKey("bpssulsel7300bpssulsel7300");

class JwtHelper{
  static JWT? tryVerify(String token){
      return JWT.tryVerify(token, secretKey);
  }

  static String generator(String username,List<String> roles){
    var jwtToken = JWT({
      "username":username,"roles":roles
    });
    var token = jwtToken.sign(secretKey);
    return token;
  }
}