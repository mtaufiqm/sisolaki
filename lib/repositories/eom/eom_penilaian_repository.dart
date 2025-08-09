

import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/eom/eom_penilaian.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:uuid/uuid.dart';

class EomPenilaianRepository {
  MyConnectionPool conn;

  EomPenilaianRepository(this.conn);

  Future<EomPenilaian> getByUuid(dynamic uuid) async {
    return this.conn.connectionPool.runTx<EomPenilaian>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_penilaian WHERE uuid = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      return EomPenilaian.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomPenilaian> create(EomPenilaian object) async {
    return this.conn.connectionPool.runTx<EomPenilaian>((tx) async {
        String uuid = Uuid().v1();
        String current_time = DatetimeHelper.getCurrentMakassarTime();

        object.uuid = uuid;
        object.created_at = current_time;
        object.last_updated = current_time;

        //if it first created, automatically set status to 0 : BELUM MULAI;
        object.status = 0;

        var result = await tx.execute(r"INSERT INTO eom_penilaian VALUES($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *",parameters: [
          object.uuid,
          object.desc,
          object.periode,
          object.start_date,
          object.end_date,
          object.status,
          object.created_at,
          object.last_updated
        ]);
        if(result.isEmpty){
          throw Exception("Failed Insert Data Penilaian ${object.periode}");
        }
        return EomPenilaian.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomPenilaian> update(String uuid, EomPenilaian object) async {
    return this.conn.connectionPool.runTx<EomPenilaian>((tx) async {
      String current_time = DatetimeHelper.getCurrentMakassarTime();

      //update last_updated
      object.last_updated = current_time;
      object.uuid = uuid;

      var result = await tx.execute(r"UPDATE eom_penilaian SET desc = $1, periode = $2, start_date = $3, end_date = $4, status = $5, created_at = $6, last_updated = $7 WHERE uuid = $8 RETURNING *",parameters: [
        object.desc,
        object.periode,
        object.start_date,
        object.end_date,
        object.status,
        object.created_at,
        object.last_updated,
        object.uuid
      ]);
      if(result.isEmpty){
        throw Exception("Failed Update Data Penilaian ${object.periode}");
      }
      return EomPenilaian.fromJson(result.first.toColumnMap());
    });
  }

  Future<List<EomPenilaian>> readAll() async {
    return this.conn.connectionPool.runTx<List<EomPenilaian>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_penilaian ep ORDER BY ep.periode DESC");
      List<EomPenilaian> listObject = [];
      for(var item in result){
        listObject.add(EomPenilaian.fromJson(item.toColumnMap()));
      }
      return listObject;
    });
  }

  //0: BELUM MULAI
  //1: AKTIF
  //2: SELESAI
  Future<List<EomPenilaian>> readByStatus(int status) async {
    return this.conn.connectionPool.runTx<List<EomPenilaian>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_penilaian ep WHERE ep.status = $1 ORDER BY ep.periode DESC", parameters: [
        status
      ]);

      List<EomPenilaian> listObject = [];
      for(var item in result){
        listObject.add(EomPenilaian.fromJson(item.toColumnMap()));
      }
      return listObject;
    });
  }

  Future<void> delete(dynamic uuid) async {
    return this.conn.connectionPool.runTx<void>((tx) async {
      var result = await tx.execute(r"DELETE FROM eom_penilaian WHERE uuid = $1", parameters: [
        uuid as String
      ]);
      if(result.affectedRows <= 0){
        throw Exception("Failed Delete Data ${uuid as String}");
      }
    });
  }
}