import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/report_repository.dart';
import 'package:bpssulsel/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return handler.use(provider<UserRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    UserRepository userRepo = UserRepository(conn);
    return userRepo;
  })).use(provider<ReportRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    ReportRepository reportRepo = ReportRepository(conn);
    return reportRepo;
  }));
}

