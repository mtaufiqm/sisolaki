import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_questions.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class Penilaian360QuestionsRepository {
  MyConnectionPool conn;

  Penilaian360QuestionsRepository(this.conn);

  Future<List<Penilaian360Questions>> readAll() async {
    return this.conn.connectionPool.runTx<List<Penilaian360Questions>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM penilaian360_questions pq ORDER BY pq.order ASC, pq.is_active DESC");
      List<Penilaian360Questions> listObject = [];
      for(var item in result){
        var object = Penilaian360Questions.fromJson(item.toColumnMap());
        listObject.add(object);
      }
      return listObject;
    });
  }

  Future<List<Penilaian360QuestionsAnswer>> getQuestionsAnswerByPenilaian360Uuid(String uuid) async {
    return this.conn.connectionPool.runTx<List<Penilaian360QuestionsAnswer>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_penilaian360 ep360 WHERE ep360.uuid = $1",parameters: [uuid]);

      if(result.isEmpty) {
        throw Exception("There is No Data ${uuid}");
      }

      var penilaian360 =  EomPenilaian360.fromJson(result.first.toColumnMap());

      List<Penilaian360QuestionsAnswer> listObject = [];

      //if its complete, return all answer with questions related.
      if(penilaian360.is_complete){
        String query = r'''
SELECT
pq.*,
pa.uuid as pa_uuid,
pa.penilaian360 as pa_penilaian360,
pa.question as pa_question,
pa.value as pa_value

FROM penilaian360_answers pa
LEFT JOIN penilaian360_questions pq
ON pa.question = pq.uuid

WHERE pa.penilaian360 = $1

ORDER BY
pq.order ASC

''';
        var result2 = await tx.execute(query,parameters: [uuid]);     
        for(var item in result2){
          Penilaian360QuestionsAnswer object = Penilaian360QuestionsAnswer.fromDb(item.toColumnMap());
          object.answer = Penilaian360Answers.fromDb(item.toColumnMap());
          listObject.add(object);
        }
      }

  // String? uuid;
  // String penilaian360;
  // String question;
  // int value;

      //if not complete, return all available current questions with answer is null.
      if(!penilaian360.is_complete){
        var result2 = await tx.execute(r"SELECT * FROM penilaian360_questions pq WHERE pq.is_active = TRUE ORDER BY pq.order ASC");
        for(var item in result2){
          listObject.add(
            Penilaian360QuestionsAnswer.fromDb(item.toColumnMap())
          );
        }
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