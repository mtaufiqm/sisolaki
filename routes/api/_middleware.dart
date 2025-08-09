import 'package:bpssulsel/helper/jwt_helper.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:bpssulsel/models/roles.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/user_repository.dart';


Handler middleware(Handler handler){
  return handler.use(bearerAuthentication<User>(
    authenticator: (context,token) async{
      JWT? jwtToken = JwtHelper.tryVerify(token);
      //print("Token : ${token}");
      //print(jwtToken??"Invalid JWT");
      if(jwtToken == null){
        return null;
      }
      var connection = context.read<MyConnectionPool>();
      String username = jwtToken!.payload["username"] as String;
      List<String> roles = (jwtToken!.payload["roles"] as List).cast<String>();
      var userRepository = UserRepository(connection);
      try{
        //this check if user with username exists in db
        User myUser = await userRepository.getById(jwtToken!.payload["username"]);
        myUser.roles = roles;

        //check user active status
        if(!myUser.is_active) {
          return null;
        }
        return myUser;
      } catch(e){
        //IF FAIL GET THAT USERNAME IN DB, PREVENT IT FOR ACCESS 
        ////THIS PREVENT FOR DELETED ACCOUNT TO ACCESS APIs
        return null;
      }
    }
  ));
}
