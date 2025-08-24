import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/eom/eom_data.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class EomDataRepository {
  MyConnectionPool conn;

  EomDataRepository(this.conn);

  Future<EomData> getByUuid(String uuid) async {
    return this.conn.connectionPool.runTx<EomData>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_data WHERE uuid = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      return EomData.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomData> getByCandidateUuid(String uuid) async {
    return this.conn.connectionPool.runTx<EomData>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_data ed WHERE ed.candidate = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      return EomData.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomData> updateByCandidateUuid(String uuid, EomData data) async {
    return this.conn.connectionPool.runTx<EomData>((tx) async {
      String last_updated = DatetimeHelper.getCurrentMakassarTime();
      data.candidate = uuid;
      data.last_updated = last_updated;
      var result = await tx.execute(r"UPDATE eom_data SET kjk = $1, vote = $2, ckp = $3, last_updated = $4 WHERE candidate = $5 RETURNING *",parameters: [
        data.kjk,
        data.vote,
        data.ckp,
        data.last_updated,
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("Failed Update Data");
      }
      return EomData.fromJson(result.first.toColumnMap());
    }); 
  }
}