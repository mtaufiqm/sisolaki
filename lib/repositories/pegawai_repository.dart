import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:bpssulsel/repositories/myrepository.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class PegawaiRepository extends MyRepository<Pegawai>{
  final MyConnectionPool connection;
  PegawaiRepository(this.connection);
   Future<void> delete(dynamic pegawaiUuid) async{
    return this.connection.connectionPool.withConnection<void>((cnn) async{
      await cnn.runTx<void>((tx) async {
        await tx.execute(r'DELETE FROM PEGAWAI WHERE uuid = $1',parameters: [pegawaiUuid as String]);
      });
      return;
    });
  }
  
  Future<List<Pegawai>> readAll() async{
    return this.connection.connectionPool.withConnection<List<Pegawai>>((conn) async {
      return conn.runTx((tx) async {
        Result result = await tx.execute('SELECT * FROM pegawai ORDER BY nip ASC');
        List<Pegawai> listOfPegawai = <Pegawai>[];
        for(ResultRow i in result){
          Map<String,dynamic> mapRow = i.toColumnMap();
          Pegawai pegawai = Pegawai.fromJson(mapRow);
          listOfPegawai.add(pegawai);
        }
        return listOfPegawai;
      });
    });
  }

      // 'uuid': uuid,
      // 'fullname': fullname,
      // 'fullname_with_title': fullname_with_title,
      // 'nickname': nickname,
      // 'date_of_birth': date_of_birth,
      // 'city_of_birth': city_of_birth,
      // 'nip': nip,
      // 'old_nip': old_nip,
      // 'age': age,
      // 'username': username,
      // 'status_pegawai': status_pegawai,


  Future<Pegawai> create(Pegawai pegawai) async {
    return this.connection.connectionPool.withConnection((conn) async{
      return conn.runTx<Pegawai>((tx) async{
        String uuid = Uuid().v1();
        pegawai.uuid = uuid;
        Result result = await tx.execute(r'INSERT INTO pegawai VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING uuid',
        parameters: [
          pegawai.uuid,
          pegawai.fullname,
          pegawai.fullname_with_title,
          pegawai.nickname,
          pegawai.nip,
          pegawai.old_nip,
          pegawai.phone_number,
          pegawai.username,
          pegawai.status_pegawai,
          pegawai.jabatan
        ]);
        if(result.isEmpty){
          throw Exception("Error Create Pegawai ${uuid}");
        }
        return pegawai;
      });
    });
  }

  Future<Pegawai> update(dynamic pegawaiUuid, Pegawai pegawai) async{
    return this.connection.connectionPool.runTx<Pegawai>((tx) async {
      var result = await tx.execute(r'UPDATE pegawai SET fullname = $1, fullname_with_title = $2, nickname = $3, nip = $4, old_nip = $5, phone_number = $6, username = $7, status_pegawai = $8, jabatan = $9 WHERE uuid = $10',
      parameters: [
        pegawai.fullname,
        pegawai.fullname_with_title,
        pegawai.nickname,
        pegawai.nip,
        pegawai.old_nip,
        pegawai.phone_number,
        pegawai.username,
        pegawai.status_pegawai,
        pegawai.jabatan,
        pegawaiUuid as String
      ]);
      if(result.affectedRows < 1){
        throw Exception("There is no row updated!");
      }
      return pegawai;
    });
  }

  Future<Pegawai> getById(dynamic pegawaiUuid) async{
    return this.connection.connectionPool.runTx((tx) async{
      Result hasil = await tx.execute(r'SELECT * FROM pegawai WHERE uuid = $1',parameters: [pegawaiUuid as String]);
      Pegawai pegawai;
      if(hasil.isEmpty){
        throw Exception("There is no Data ${pegawaiUuid as String}");
      }
      var pegawaiMap = hasil.first.toColumnMap();
      pegawai = Pegawai.fromJson(pegawaiMap);
      return pegawai;
    });
  }

  

  Future<Pegawai> getByUsername(dynamic pegawaiUsername) async{
    return this.connection.connectionPool.runTx((tx) async{
      Result hasil = await tx.execute(r'SELECT * FROM pegawai WHERE username = $1',parameters: [pegawaiUsername as String]);
      Pegawai pegawai;
      if(hasil.isEmpty){
        throw Exception("There is no Data ${pegawaiUsername as String}");
      }
      var pegawaiMap = hasil.first.toColumnMap();
      pegawai = Pegawai.fromJson(pegawaiMap);
      return pegawai;
    });
  }
}