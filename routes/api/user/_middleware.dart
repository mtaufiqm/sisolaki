import 'package:dart_frog/dart_frog.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/user_repository.dart';


//ADD USER REPOSITORY

Handler middleware(Handler handler) {

  // TODO: implement middleware
  return handler.use(provider<UserRepository>((context) {
    var connectionPool = context.read<MyConnectionPool>();
    return UserRepository(connectionPool);
  }));
}
