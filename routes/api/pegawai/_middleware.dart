import 'package:dart_frog/dart_frog.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';

Handler middleware(Handler handler) {
  // TODO: implement middleware
  return handler.use(provider<PegawaiRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    PegawaiRepository pegawaiRepository = PegawaiRepository(conn);
    return pegawaiRepository;
  }));
}
