import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/models/tim_pegawai.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class TimRepository {
  MyConnectionPool conn;

  TimRepository(this.conn);

  Future<Tim> getById(dynamic id) async {
    return Tim.fromJson({});
  }

  Future<TimWithPegawai> getDetailsById(String id) async {
    return this.conn.connectionPool.runTx((tx) async {
      var result = await tx.execute(r"SELECT * FROM tim WHERE tim.uuid = $1",parameters: [id]);
      if(result.isEmpty){
        throw Exception("There is no Data");
      }
      var timDetails = TimWithPegawai.fromDb(result.first.toColumnMap());
      String query = r'''
SELECT
pt.*,

p.uuid as p_uuid,
p.fullname as p_fullname,
p.fullname_with_title as p_fullname_with_title,
p.nickname as p_nickname,
p.nip as p_nip,
p.old_nip as p_old_nip,
p.phone_number as p_phone_number,
p.username as p_username,
p.status_pegawai as p_status_pegawai,
p.jabatan as p_jabatan

FROM pegawai_tim pt

LEFT JOIN pegawai p
ON pt.pegawai = p.uuid

LEFT JOIN tim_role tr
ON pt.tim_role = tr.id

WHERE pt.tim = $1

ORDER BY pt.tim_role ASC

''';
      var result2 = await tx.execute(query,parameters: [id]);
      List<TimPegawai> timPegawai = [];

      for(var item in result2){
        TimPegawai object = TimPegawai.fromDb(item.toColumnMap());
        object.pegawai = Pegawai.fromDbPrefix(item.toColumnMap(), "p");
        timPegawai.add(object);
      }

      timDetails.pegawai = timPegawai;
      return timDetails;
    });
  }

  Future<Tim> update(dynamic id, Tim object) async {
    return object;
  }

  Future<Tim> create(Tim object) async {
    return this.conn.connectionPool.runTx<Tim>((tx) async {
      String uuid = Uuid().v1();
      object.uuid = uuid;
      var result = await tx.execute(r"INSERT INTO tim VALUES($1,$2,$3) RETURNING *",parameters: [
        object.uuid!,
        object.title,
        object.desc
      ]);
      if(result.isEmpty){
        throw Exception("Failed Insert New Tim");
      }
      return Tim.fromJson(result.first.toColumnMap());
    });
  }

  Future<List<Tim>> readAll() async {
    return this.conn.connectionPool.runTx((tx) async {
      var result = await tx.execute(r"SELECT * FROM tim");
      return result.map((el) {
        return Tim.fromJson(el.toColumnMap());
      }).toList();
    });
  }
  Future<void> delete(dynamic id) async {

  }

  Future<List<TimPegawai>> getTimByPegawaiUuid(String uuid) async {
    return this.conn.connectionPool.runTx<List<TimPegawai>>((tx) async{
      String query = r'''
SELECT
pt.*,

p.uuid as p_uuid,
p.fullname as p_fullname,
p.fullname_with_title as p_fullname_with_title,
p.nickname as p_nickname,
p.nip as p_nip,
p.old_nip as p_old_nip,
p.phone_number as p_phone_number,
p.username as p_username,
p.status_pegawai as p_status_pegawai,
p.jabatan as p_jabatan,

t.uuid as t_uuid,
t.title as t_title,
t.desc as t_desc

FROM pegawai_tim pt

LEFT JOIN pegawai p
ON pt.pegawai = p.uuid

LEFT JOIN tim t
ON pt.tim = t.uuid

WHERE pt.pegawai = $1
''';
      Result hasil = await tx.execute(query,parameters: [uuid as String]);
      if(hasil.isEmpty){
        return [];
      }
      return hasil.map((el) {
        Map<String,dynamic> map = el.toColumnMap();
        TimPegawai item = TimPegawai.fromDb(map);
        Tim tim = Tim.fromDbPrefix(map, "t");
        Pegawai pegawai = Pegawai.fromDbPrefix(map, "p");
        item.tim = tim;
        item.pegawai = pegawai;
        return item;
      }).toList();
    });
  }

  //this will delete old tim and insert new one tim;
  Future<void> setTimForSpesificPegawai(TimPegawaiDTO object) async {
   return this.conn.connectionPool.runTx<void>((tx) async {
      var result = await tx.execute(r"DELETE FROM pegawai_tim pt WHERE pt.pegawai = $1",parameters: [
        object.pegawai
      ]);
      String uuid = Uuid().v1();
      var result1 = await tx.execute(r"INSERT INTO pegawai_tim VALUES($1,$2,$3,$4) RETURNING uuid",parameters: [
        uuid,
        object.pegawai,
        object.tim,
        object.tim_role
      ]);
      if(result1.isEmpty){
        throw Exception("Fail set Tim for pegawai ${object.pegawai}");
      }
      return;
   });
  }

  //this will delete old;
  Future<void> clearTimForSpesificPegawai(String pegawai) async {
   return this.conn.connectionPool.runTx<void>((tx) async {
      var result = await tx.execute(r"DELETE FROM pegawai_tim pt WHERE pt.pegawai = $1",parameters: [
        pegawai
      ]);
      return;
   });
  }
}