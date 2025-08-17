import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/eom/eom_candidate.dart';
import 'package:bpssulsel/models/eom/eom_data.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';
import 'package:bpssulsel/repositories/myconnection.dart';
import 'package:uuid/uuid.dart';

class EomCandidateRepository {
  MyConnectionPool conn;

  EomCandidateRepository(this.conn);

  Future<EomCandidate> getByUuid(dynamic uuid) async {
    return this.conn.connectionPool.runTx<EomCandidate>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_candidate WHERE uuid = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      return EomCandidate.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomCandidateDetails> getDetailsByUuid(dynamic uuid) async {
    return this.conn.connectionPool.runTx<EomCandidateDetails>((tx) async {
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
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      var mapObject = result.first.toColumnMap();
      EomCandidateDetails object = EomCandidateDetails.fromDb(mapObject);
      object.pegawai = PegawaiDetails.fromJson(mapObject);
      object.tim = TimDetails.fromJson(mapObject);
      return object;
    }); 
  }

  Future<EomCandidateWithData> create(EomCandidateWithData object) async {
    return this.conn.connectionPool.runTx<EomCandidateWithData>((tx) async {
        String uuid = Uuid().v1();


        var maxOrderValue = await tx.execute(r"SELECT coalesce(max(ec.order),0) as max_order FROM eom_candidate ec WHERE ec.penilaian = $1",parameters: [object.penilaian]);

        int order = 0;

        if(!maxOrderValue.isEmpty){
          order = (maxOrderValue.first.toColumnMap()["max_order"] as int?)??0;
        }

        object.uuid = uuid;
        object.order = order+1;

        var result = await tx.execute(r"INSERT INTO eom_candidate VALUES($1,$2,$3,$4,$5) RETURNING *",parameters: [
          object.uuid,
          object.penilaian,
          object.order,
          object.tim,
          object.pegawai
        ]);

        if(result.isEmpty){
          throw Exception("Failed Insert Data Penilaian ${object.uuid}");
        }

        var createdObject = await EomCandidateWithData.fromDb(result.first.toColumnMap());

        if(object.data == null){
          throw Exception("There is no related Data");
        }
        String uuid2 = Uuid().v1();
        String current_time = DatetimeHelper.getCurrentMakassarTime();
        var inputData = object.data!;
        inputData.uuid = uuid2;
        inputData.created_at = current_time;
        inputData.last_updated = current_time;
        //insert data to related candidate
        var result2 = await tx.execute(r"INSERT INTO eom_data VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING *",parameters: [
          inputData.uuid,
          createdObject.uuid,
          inputData.kjk,
          0,
          inputData.ckp,
          inputData.created_at,
          inputData.last_updated
        ]);
        if(result2.isEmpty){
          throw Exception("Fail create data candidate");
        }
        createdObject.data = EomData.fromDb(result2.first.toColumnMap());
        return createdObject;
    }); 
  }

  Future<EomCandidate> update(String uuid, EomCandidate object) async {
    return this.conn.connectionPool.runTx<EomCandidate>((tx) async {
      String current_time = DatetimeHelper.getCurrentMakassarTime();

      object.uuid = uuid;

      var result = await tx.execute(r'''
UPDATE eom_candidate 
SET 
penilaian = $1, 
order = $2, 
tim = $3, 
pegawai = $4 

WHERE uuid = $5 
RETURNING *
''',parameters: [
        object.penilaian,
        object.order,
        object.tim,
        object.pegawai,
        object.uuid
      ]);
      if(result.isEmpty){
        throw Exception("Failed Update Data Penilaian ${object.pegawai}");
      }
      return EomCandidate.fromJson(result.first.toColumnMap());
    });
  }

  Future<List<EomCandidate>> readAll() async {
    return this.conn.connectionPool.runTx<List<EomCandidate>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_candidate ec ORDER BY ec.penilaian DESC, ec.order ASC");
      List<EomCandidate> listObject = [];
      for(var item in result){
        listObject.add(EomCandidate.fromJson(item.toColumnMap()));
      }
      return listObject;
    });
  }

  //0: BELUM MULAI
  //1: AKTIF
  //2: SELESAI
  Future<List<EomCandidate>> readByPenilaian(String penilaian_uuid) async {
    return this.conn.connectionPool.runTx<List<EomCandidate>>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_candidate ec WHERE ec.penilaian = $1 ORDER BY ec.order ASC", parameters: [
        penilaian_uuid
      ]);

      List<EomCandidate> listObject = [];
      for(var item in result){
        listObject.add(EomCandidate.fromJson(item.toColumnMap()));
      }
      return listObject;
    });
  }

    
  Future<List<EomCandidateDetails>> readDetailsByPenilaian(String penilaian_uuid) async {
    return this.conn.connectionPool.runTx<List<EomCandidateDetails>>((tx) async {

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
  tim.desc as tim_desc,

  ed.uuid as ed_uuid,
  ed.candidate as ed_candidate,
  ed.kjk as ed_kjk,
  ed.vote as ed_vote,
  ed.ckp as ed_ckp,
  ed.created_at as ed_created_at,
  ed.last_updated as ed_last_updated


FROM eom_candidate ec
LEFT JOIN tim
ON ec.tim = tim.uuid

LEFT JOIN pegawai p
ON ec.pegawai = p.uuid

LEFT JOIN eom_data ed
ON ec.uuid = ed.candidate

WHERE ec.penilaian = $1
''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid
      ]);

      List<EomCandidateDetails> listObject = [];

      for(var item in result) {
        var mapObject = item.toColumnMap();
        EomCandidateDetails object = EomCandidateDetails.fromDb(mapObject);
        object.pegawai = PegawaiDetails.fromJson(mapObject);
        object.tim = TimDetails.fromJson(mapObject);
        object.data = EomData.fromDbPrefix(mapObject, "ed");
        listObject.add(object);
      }
      return listObject;
    });
  }



  Future<void> delete(dynamic uuid) async {
    return this.conn.connectionPool.runTx<void>((tx) async {
      var result = await tx.execute(r"DELETE FROM eom_candidate WHERE uuid = $1", parameters: [
        uuid as String
      ]);
      print("Success Hapus Kandidat");
      if(result.affectedRows <= 0){
        throw Exception("Failed Delete Data ${uuid as String}");
      }
    });
  }

  Future<List<VoteResult>> calculateResult(String penilaian_uuid) async {
      return this.conn.connectionPool.runTx<List<VoteResult>>((tx) async {
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
  tim.desc as tim_desc,

  ed.uuid as ed_uuid,
  ed.candidate as ed_candidate,
  ed.kjk as ed_kjk,
  ed.vote as ed_vote,
  ed.ckp as ed_ckp,
  ed.created_at as ed_created_at,
  ed.last_updated as ed_last_updated


FROM eom_candidate ec
LEFT JOIN tim
ON ec.tim = tim.uuid

LEFT JOIN pegawai p
ON ec.pegawai = p.uuid

LEFT JOIN eom_data ed
ON ec.uuid = ed.candidate

WHERE ec.penilaian = $1
''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid
      ]);
      List<EomCandidateDetails> listObject = [];
      for(var item in result) {
        var mapObject = item.toColumnMap();
        EomCandidateDetails object = EomCandidateDetails.fromDb(mapObject);
        object.pegawai = PegawaiDetails.fromJson(mapObject);
        object.tim = TimDetails.fromJson(mapObject);
        object.data = EomData.fromDbPrefix(mapObject, "ed");
        listObject.add(object);
      }
      // Map<String,dynamic> value = {"vote":0,"penilaian360":0.0};
      // Map<String,Map<String,dynamic>> candidateValue = {};
      // listObject.forEach((el) {
      //   candidateValue[el.uuid!] = value;
      // });
      List<VoteResult> voteResultList = [];
      //calculate value based actual condition
      for(var item in listObject){
        var result2 = await tx.execute(r"SELECT COALESCE(COUNT(CASE WHEN ev.choice1 = $1 OR ev.choice2 = $1 THEN 1 END),0) as vote FROM eom_vote ev WHERE ev.penilaian = $2",parameters: [
          item.pegawai!.p_uuid!,
          penilaian_uuid
        ]);
        int vote = result2.first.toColumnMap()["vote"] as int;
        var result3 = await tx.execute(r"SELECT COALESCE(AVG(ep360.value),0.0) as penilaian360 FROM eom_penilaian360 ep360 WHERE ep360.is_complete = TRUE AND ep360.penilaian = $1 AND ep360.candidate = $2",parameters: [
          penilaian_uuid,
          item.uuid!
        ]);
        double penilaian360 = result3.first.toColumnMap()["penilaian360"] as double;
        VoteResult voteResult = VoteResult(
          candidate: item, 
          kjk: item.data!.kjk, 
          ckp: item.data!.ckp, 
          vote: vote, 
          penilaian360: penilaian360, 
          average: 0.0
        );
        voteResult.average = calculateAverage(
          kjk: voteResult.kjk, 
          ckp: voteResult.ckp, 
          vote: voteResult.vote, 
          penilaian360: voteResult.penilaian360  
        );
        voteResultList.add(voteResult);
      }
      return voteResultList;
    });
  }
}

double calculateAverage({
  required double kjk,
  required double ckp,
  required int vote,
  required double penilaian360
}) {
  double presensi = 100.0 - kjk;
  if(presensi < 0.0){
    presensi = 0.0;
  }
  if(presensi > 100.0){
    presensi = 100.0;
  }
  double firstAverage = 0.3*vote + 0.35*ckp + 0.35*presensi;
  double secondAverage = 0.5*firstAverage + 0.5*penilaian360;
  return secondAverage;
}