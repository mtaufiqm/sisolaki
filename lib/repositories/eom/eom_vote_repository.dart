
import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:bpssulsel/models/eom/eom_vote.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/repositories/myconnection.dart';

class EomVoteRepository {
  MyConnectionPool conn;

  EomVoteRepository(this.conn);

  Future<EomVote> update(String uuid, EomVote object) async {
    return this.conn.connectionPool.runTx<EomVote>((tx) async {
      String current_time = DatetimeHelper.getCurrentMakassarTime();

      object.uuid = uuid;

      var result = await tx.execute(r'''
UPDATE eom_vote 
SET 
penilaian = $1, 
voter = $2, 
choice1 = $3,
choice2 = $4, 
created_at = $5,
last_updated = $6,
is_complete = $7 

WHERE uuid = $8 
RETURNING *
''',parameters: [
        object.penilaian,
        object.voter,
        object.choice1,
        object.choice2,
        object.created_at,
        object.last_updated,
        object.is_complete,
        object.uuid!
      ]);
      if(result.isEmpty){
        throw Exception("Failed Update Data Penilaian ${object.uuid}");
      }
      return EomVote.fromJson(result.first.toColumnMap());
    });
  }

  Future<EomVote> getByUuid(dynamic uuid) async {
    return this.conn.connectionPool.runTx<EomVote>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_vote WHERE uuid = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      return EomVote.fromJson(result.first.toColumnMap());
    }); 
  }

  Future<EomVoteDetails> getDetailsByUuid(dynamic uuid) async {
    return this.conn.connectionPool.runTx<EomVoteDetails>((tx) async {
      var result = await tx.execute(r"SELECT * FROM eom_vote WHERE uuid = $1",parameters: [
        uuid as String
      ]);
      if(result.isEmpty){
        throw Exception("There is No Data ${uuid as String}");
      }
      var row = result.first.toColumnMap();
      var voteDetails = EomVoteDetails.fromDb(row);
      if(row["voter"] != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["voter"] as String]);
        if(!result2.isEmpty){
          voteDetails.voter = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }

      if(row["choice1"] != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["choice1"] as String]);
        if(!result2.isEmpty){
          voteDetails.choice1 = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }

      if(row["choice2"] != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["choice2"] as String]);
        if(!result2.isEmpty){
          voteDetails.choice2 = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }
      return voteDetails;
    }); 
  }


  Future<EomVoteDetails> getDetailsByPenilaianAndVoterUsername(String penilaian_uuid, String voter_username) async {
    return this.conn.connectionPool.runTx<EomVoteDetails>((tx) async {
      var query = r'''
SELECT ev.* 

FROM eom_vote ev
LEFT JOIN pegawai p
ON ev.voter = p.uuid

WHERE
ev.penilaian = $1
AND
p.username = $2

''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid, voter_username
      ]);
      if(result.isEmpty){
        throw Exception("There is No Vote Data ${penilaian_uuid} - ${voter_username}");
      }

      var row = result.first.toColumnMap();
      var voteDetails = EomVoteDetails.fromDb(row);


      if(row["voter"] != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["voter"] as String]);
        if(!result2.isEmpty){
          voteDetails.voter = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }

      if((row["choice1"] as String?) != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["choice1"] as String]);
        if(!result2.isEmpty){
          voteDetails.choice1 = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }

      if((row["choice2"] as String?) != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["choice2"] as String]);
        if(!result2.isEmpty){
          voteDetails.choice2 = Pegawai.fromJson(result2.first.toColumnMap());
        }
      }
      return voteDetails;
    }); 
  }

  Future<bool> isExistsByPenilaianAndVoterUsername(String penilaian_uuid, String voter_username) async {
    return this.conn.connectionPool.runTx<bool>((tx) async {
      var query = r'''
SELECT ev.* 

FROM eom_vote ev
LEFT JOIN pegawai p
ON ev.voter = p.uuid

WHERE
ev.penilaian = $1
AND
p.username = $2

''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid, voter_username
      ]);
      if(result.isEmpty){
        return false;
      }
      return true;
    });
  }


  Future<List<EomVoteDetails>> readDetailsByPenilaian(String penilaian_uuid) async {
    return this.conn.connectionPool.runTx<List<EomVoteDetails>>((tx) async {
      var query = r'''
SELECT 

ev.*,

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

p1.uuid as p1_uuid,
p1.fullname as p1_fullname,
p1.fullname_with_title as p1_fullname_with_title,
p1.nickname as p1_nickname,
p1.nip as p1_nip,
p1.old_nip as p1_old_nip,
p1.phone_number as p1_phone_number,
p1.username as p1_username,
p1.status_pegawai as p1_status_pegawai,
p1.jabatan as p1_jabatan,

p2.uuid as p2_uuid,
p2.fullname as p2_fullname,
p2.fullname_with_title as p2_fullname_with_title,
p2.nickname as p2_nickname,
p2.nip as p2_nip,
p2.old_nip as p2_old_nip,
p2.phone_number as p2_phone_number,
p2.username as p2_username,
p2.status_pegawai as p2_status_pegawai,
p2.jabatan as p2_jabatan

FROM eom_vote ev

LEFT JOIN pegawai p
ON ev.voter = p.uuid

LEFT JOIN pegawai p1
ON ev.choice1 = p1.uuid

LEFT JOIN pegawai p2
ON ev.choice2 = p2.uuid

WHERE
ev.penilaian = $1

ORDER BY ev.is_complete ASC, ev.last_updated DESC
''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid
      ]);
      List<EomVoteDetails> listObject = result.map((el) {
        var itemMap = el.toColumnMap();
        EomVoteDetails voteItem = EomVoteDetails.fromDb(itemMap);
        voteItem.voter = Pegawai.fromDbPrefix(itemMap, "p");
        try {
          voteItem.choice1 = Pegawai.fromDbPrefix(itemMap,"p1");
        } catch(err){}
        try {
          voteItem.choice2 = Pegawai.fromDbPrefix(itemMap,"p2");
        } catch(err){}
        return voteItem;
      }).toList();
      return listObject;
    }); 
  }

  Future<List<EomVoteDetails>> readMoreDetailsByPenilaian(String penilaian_uuid) async {
    return this.conn.connectionPool.runTx<List<EomVoteDetails>>((tx) async {
      var query = r'''
SELECT 

ev.*,

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

p1.uuid as p1_uuid,
p1.fullname as p1_fullname,
p1.fullname_with_title as p1_fullname_with_title,
p1.nickname as p1_nickname,
p1.nip as p1_nip,
p1.old_nip as p1_old_nip,
p1.phone_number as p1_phone_number,
p1.username as p1_username,
p1.status_pegawai as p1_status_pegawai,
p1.jabatan as p1_jabatan,

p2.uuid as p2_uuid,
p2.fullname as p2_fullname,
p2.fullname_with_title as p2_fullname_with_title,
p2.nickname as p2_nickname,
p2.nip as p2_nip,
p2.old_nip as p2_old_nip,
p2.phone_number as p2_phone_number,
p2.username as p2_username,
p2.status_pegawai as p2_status_pegawai,
p2.jabatan as p2_jabatan

FROM eom_vote ev

LEFT JOIN pegawai p
ON ev.voter = p.uuid

LEFT JOIN pegawai p1
ON ev.choice1 = p1.uuid

LEFT JOIN pegawai p2
ON ev.choice2 = p2.uuid

WHERE
ev.penilaian = $1

ORDER BY ev.last_updated DESC
''';
      var result = await tx.execute(query,parameters: [
        penilaian_uuid
      ]);
      List<EomVoteDetails> listObject = result.map((el) {
        var itemMap = el.toColumnMap();
        EomVoteDetails voteItem = EomVoteDetails.fromDb(itemMap);
        voteItem.voter = Pegawai.fromDbPrefix(itemMap, "p");
        try {
          voteItem.choice1 = Pegawai.fromDbPrefix(itemMap,"p1");
        } catch(err){}
        try {
          voteItem.choice2 = Pegawai.fromDbPrefix(itemMap,"p2");
        } catch(err){}
        return voteItem;
      }).toList();
      return listObject;
    }); 
  }
}