import 'package:bpssulsel/models/eom/penilaian360/penilaian360_questions.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class Penilaian360QuestionsRepository {
  MyConnectionPool conn;

  Penilaian360QuestionsRepository(this.conn);

  Future<List<Penilaian360Questions>> readAll() async {
    return this.conn.connectionPool.runTx<List<Penilaian360Questions>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM penilaian360_questions pq ORDER BY pq.order ASC");
      List<Penilaian360Questions> listObject = [];
      for(var item in result){
        var object = Penilaian360Questions.fromJson(item.toColumnMap());
        listObject.add(object);
      }
      return listObject;
    });
  }

  Future<List<Penilaian360Questions>> readByActiveStatus(bool is_active) async {
    return this.conn.connectionPool.runTx<List<Penilaian360Questions>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM penilaian360_questions pq WHERE pq.is_active = $1 ORDER BY pq.order ASC",parameters: [is_active]);
      List<Penilaian360Questions> listObject = [];
      for(var item in result){
        var object = Penilaian360Questions.fromJson(item.toColumnMap());
        listObject.add(object);
      }
      return listObject;
    });
  }
}