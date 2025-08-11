import 'package:bpssulsel/repositories/eom/eom_candidate_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_penilaian_repository.dart';
import 'package:bpssulsel/repositories/eom/eom_vote_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/eom_penilaian360_repository.dart';
import 'package:bpssulsel/repositories/eom/penilaian360/penilaian360_answers_repository.dart';
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
  })).use(provider<EomVoteRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    EomVoteRepository eomVoteRepository = EomVoteRepository(conn);
    return eomVoteRepository;
  })).use(provider<EomPenilaian360Repository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    EomPenilaian360Repository ep360Repository = EomPenilaian360Repository(conn);
    return ep360Repository;
  })).use(provider<Penilaian360AnswersRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    Penilaian360AnswersRepository ep360AnswerRepository = Penilaian360AnswersRepository(conn);
    return ep360AnswerRepository;
  })).use(provider<PegawaiRepository>((ctx){
    MyConnectionPool conn = ctx.read<MyConnectionPool>();
    PegawaiRepository pegawaiRepository = PegawaiRepository(conn);
    return pegawaiRepository;
  }));
}
