import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/pegawai_repository.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<EomPenilaianRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    EomPenilaianRepository eomPenilaianRepository = EomPenilaianRepository(conn);
    return eomPenilaianRepository;
  })).use(provider<EomCandidateRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    EomCandidateRepository eomCandidateRepository = EomCandidateRepository(conn);
    return eomCandidateRepository;
  })).use(provider<PegawaiRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    PegawaiRepository pegawaiRepository = PegawaiRepository(conn);
    return pegawaiRepository;
  }));
}
