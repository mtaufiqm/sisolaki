
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
        print("Empty Choice1");
      }

      if((row["choice2"] as String?) != null) {
        var result2 = await tx.execute(r"SELECT * FROM pegawai p WHERE p.uuid = $1",parameters: [row["choice2"] as String]);
        if(!result2.isEmpty){
          voteDetails.choice2 = Pegawai.fromJson(result2.first.toColumnMap());
        }
        
        print("Empty Choice2");
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
}