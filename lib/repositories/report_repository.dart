import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/report.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:uuid/uuid.dart';

class ReportRepository {
  MyConnectionPool conn;

  ReportRepository(this.conn);

  Future<Report> getByUuid(String uuid) async {
    return this.conn.connectionPool.runTx<Report>((tx) async {
      var result = await tx.execute(r"SELECT * FROM report WHERE uuid = $1",parameters: [uuid]);
      if(result.isEmpty){
        throw Exception("There is no Report");
      }
      return Report.fromDb(result.first.toColumnMap());
    });
  }

  // Future<T> update(dynamic id, T object);

  Future<Report> create(Report object) async {
    return this.conn.connectionPool.runTx<Report>((tx) async {
      String uuid = Uuid().v1();
      String current_time = DatetimeHelper.getCurrentMakassarTime();
      object.created_at = current_time;
      var result = await tx.execute(r"INSERT INTO report VALUES($1,$2,$3,$4,$5) RETURNING *",parameters: [
        uuid,
        object.user,
        object.title,
        object.desc,
        object.created_at!
      ]);
      if(result.isEmpty){
        throw Exception("Fail Insert New Report!");
      }
      return Report.fromDb(result.first.toColumnMap());
    });
  }
  
  Future<List<Report>> readAll() async {
    return this.conn.connectionPool.runTx<List<Report>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM report ORDER BY created_at DESC LIMIT 50");
      List<Report> listReport = result.map((el) {
        return Report.fromDb(el.toColumnMap());
      }).toList();
      return listReport;
    });
  }

  Future<void> delete(String uuid) async {
    return this.conn.connectionPool.runTx<void>((tx) async {
      var result = await tx.execute(r"DELETE FROM report WHERE uuid = $1",parameters: [uuid]);
      if(result.affectedRows <= 0){
        throw Exception("Failed Delete Data");
      }
      return;
    });
  }
}