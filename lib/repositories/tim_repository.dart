import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/models/tim_pegawai.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class TimRepository {
  MyConnectionPool conn;

  TimRepository(this.conn);

  Future<Tim> getById(dynamic id) async {
    return Tim.fromJson({});
  }

  Future<TimWithPegawai> getDetailsById(String id) async {
    return this.conn.connectionPool.runTx((tx) async {
      print("EXECUTED");
      var result = await tx.execute(r"SELECT * FROM tim WHERE tim.uuid = $1",parameters: [id]);
      if(result.isEmpty){
        throw Exception("There is no Data");
      }
      //print("EXECUTED");

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
    return object;
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
}