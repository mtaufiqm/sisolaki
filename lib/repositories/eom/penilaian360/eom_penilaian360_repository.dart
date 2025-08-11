import 'package:bpssulsel/models/eom/eom_candidate.dart';
import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class EomPenilaian360Repository {

  MyConnectionPool conn;

  EomPenilaian360Repository(this.conn);

  Future<EomPenilaian360Details> getDetailsByUuid(String ep360_uuid) async {
    return this.conn.connectionPool.runTx<EomPenilaian360Details>((tx) async {

      String query1 = r'''
SELECT 

ep360.*
 

FROM eom_penilaian360 ep360

LEFT JOIN pegawai p
ON ep360.voter = p.uuid

LEFT JOIN eom_candidate ec
ON ep360.candidate = ec.uuid

LEFT JOIN pegawai p2
ON ec.pegawai = p2.uuid


WHERE ep360.uuid = $1

''';
      var result1 = await tx.execute(query1,parameters: [ep360_uuid]);
      if(result1.isEmpty){
        throw Exception("There is no Data");
      }
      var result1_row_map = result1.first.toColumnMap();
      EomPenilaian360Details ep360_details = EomPenilaian360Details.fromDb(result1_row_map);

      String query = r'''
  SELECT 

    ec.*,

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

    tim.uuid as tim_uuid,
    tim.title as tim_title,
    tim.desc as tim_desc


  FROM eom_candidate ec
  LEFT JOIN tim
  ON ec.tim = tim.uuid

  LEFT JOIN pegawai p
  ON ec.pegawai = p.uuid

  WHERE ec.uuid = $1
  ''';
      var result = await tx.execute(query,parameters: [
        result1_row_map["candidate"] as String
      ]);
      if(!result.isEmpty){
        ep360_details.candidate = EomCandidateDetails.fromDb(result.first.toColumnMap());
      }

      var query2 = r'''
SELECT 
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

FROM pegawai p
WHERE p.uuid = $1
''';
      var result2 = await tx.execute(query2,parameters: [result1_row_map["voter"] as String]);
      if(!result2.isEmpty){
        ep360_details.voter = PegawaiDetails.fromJson(result2.first.toColumnMap());
      }
      
      return ep360_details;
    });
  }

  Future<List<EomPenilaian360Details>> readDetailsByPenilaianAndVoterUsername(String penilaian_uuid, String username) async {
    return this.conn.connectionPool.runTx<List<EomPenilaian360Details>>((tx) async {
      String query = r'''
  SELECT 

    ec.*,

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

    tim.uuid as tim_uuid,
    tim.title as tim_title,
    tim.desc as tim_desc


  FROM eom_candidate ec
  LEFT JOIN tim
  ON ec.tim = tim.uuid

  LEFT JOIN pegawai p
  ON ec.pegawai = p.uuid

  WHERE ec.penilaian = $1
  ''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid
      ]);

      Map<String,EomCandidateDetails> mapCandidate = {};

      for(var item in result) {
        var mapObject = item.toColumnMap();
        EomCandidateDetails object = EomCandidateDetails.fromDb(mapObject);
        object.pegawai = PegawaiDetails.fromJson(mapObject);
        object.tim = TimDetails.fromJson(mapObject);
        mapCandidate[object.uuid!] = object;
      }

      String query1 = r'''
SELECT 

ep360.*
 

FROM eom_penilaian360 ep360

LEFT JOIN pegawai p
ON ep360.voter = p.uuid

LEFT JOIN eom_candidate ec
ON ep360.candidate = ec.uuid

LEFT JOIN pegawai p2
ON ec.pegawai = p2.uuid


WHERE ep360.penilaian = $1
AND p.username = $2

ORDER BY ec.order ASC
''';
      var result1 = await tx.execute(query1,parameters: [penilaian_uuid,username]);
      List<EomPenilaian360Details> listObject = [];
      for(var item in result1){
        try {
          var itemMap = item.toColumnMap();
          EomPenilaian360Details ep360 = EomPenilaian360Details.fromDb(itemMap);
          ep360.candidate = mapCandidate[itemMap["candidate"] as String];
          listObject.add(ep360);
        } catch(err){
          print("Error ${err}");
        }
      }
      return listObject;
    });
  }
}