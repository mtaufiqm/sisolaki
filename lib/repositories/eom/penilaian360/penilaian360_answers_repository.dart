import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class Penilaian360AnswersRepository {
  MyConnectionPool conn;

  Penilaian360AnswersRepository(this.conn);

  Future<Penilaian360Answers> getByUuid(String uuid) async {
    return this.conn.connectionPool.runTx<Penilaian360Answers>((tx) async {
      var result = await tx.execute(r"SELECT * FROM penilaian360_answers WHERE uuid = $1",parameters: [uuid]);

      if(result.isEmpty){
        throw Exception("There is no Data ${uuid}");
      }
      return Penilaian360Answers.fromJson(result.first.toColumnMap());
    });
  }
}