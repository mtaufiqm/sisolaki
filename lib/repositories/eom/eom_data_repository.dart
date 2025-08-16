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
}