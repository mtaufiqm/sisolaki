import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_questions.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:uuid/uuid.dart';

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

  Future<List<Penilaian360Answers>> submitByPenilaian360Uuid(String penilaian360, List<Penilaian360Answers> answers){
    return this.conn.connectionPool.runTx<List<Penilaian360Answers>>((tx) async {
      if(answers.isEmpty){
        throw Exception("There is No Answers");
      }

      var result = await tx.execute(r"SELECT * FROM eom_penilaian360 WHERE uuid = $1",parameters: [
        penilaian360
      ]);
      if(result.isEmpty){
        throw Exception("There is no Data");
      }
      var object = EomPenilaian360.fromJson(result.first.toColumnMap());
      if(object.is_complete){
        throw Exception("Already Completed");
      }

      var result2 = await tx.execute(r"SELECT * FROM penilaian360_questions pq WHERE pq.is_active = TRUE ORDER BY pq.order ASC");
      List<Penilaian360Questions> listQuestions = [];
      List<String> listQuestionsUuid = [];

      List<String> answeredQuestionsUuid = answers.map((el) {
        return el.question;
      }).toList();
      for(var item in result2){
        var question = Penilaian360Questions.fromJson(item.toColumnMap());
        listQuestions.add(question);
        listQuestionsUuid.add(question.uuid!);
      }

      //verif if all questions have answer
      for(var item in listQuestionsUuid){
        if(!answeredQuestionsUuid.contains(item)){
          throw Exception("There is no Questions ${item}");
        }
      }

      //first, clear penilaian360 answer before
      var result3 = await tx.execute(r"DELETE FROM penilaian360_answers pa WHERE pa.penilaian360 = $1",parameters: [penilaian360]);

      //calculate value
      int numberOfQuestions = answers.length;
      int totalValue = 0;
      double resultValue = 0.0;

      List<Penilaian360Answers> listResultAnswer = [];
      
      //if all questions there, insert or update it
      for(var item in answers){
        if(item.value > 6) {
          throw Exception("Value More Than 6, Invalid Input!");
        }
        String uuid = Uuid().v1();
        var result4 = await tx.execute(r"INSERT INTO penilaian360_answers VALUES($1,$2,$3,$4) RETURNING *",parameters: [
          uuid,
          penilaian360,
          item.question,
          item.value
        ]);
        if(result4.isEmpty){
          throw Exception("Failed Insert Questions ${item.question}");
        }
        listResultAnswer.add(Penilaian360Answers.fromJson(result4.first.toColumnMap()));
        totalValue += item.value;
      }
      //this is result value;
      resultValue = (totalValue.toDouble()/numberOfQuestions)*100/6;
      String current_time = DatetimeHelper.getCurrentMakassarTime();
      //insert value to penilaian360
      var result5 = await tx.execute(r"UPDATE eom_penilaian360 SET value = $1, is_complete = $2, last_updated = $3 WHERE uuid = $4",parameters: [
        resultValue,true,current_time,penilaian360
      ]);
      return listResultAnswer;
    });
  }
}