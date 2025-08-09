import 'dart:io';

import 'package:bpssulsel/helper/hash_crypt_helper.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/user.dart';
import 'package:excel/excel.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  Pool poolConn = prepareConnection();
  String fileName = "InitData.xlsx";

  Excel excelFile = Excel.decodeBytes(File(fileName).readAsBytesSync());
  Sheet firstSheet = excelFile.sheets.values.first;
  var rows = firstSheet.rows;
  await poolConn.runTx((tx) async {
    for(int i = 0; i < rows.length; i++){
      if(i == 0){
        continue;
      }
      try {
        var row = rows[i];
        String email = row[0]!.value!.toString();
        String username = email;
        String plainPass = "${username.split("@")[0]}_7300";
        String hashedPass = HashCryptHelper.hashPassword(plainPass);
        bool is_active = true;

        String fullname = row[1]!.value!.toString();
        String fullname_with_title = row[2]!.value!.toString();
        int jabatanPegawai = int.parse(row[6]!.value!.toString());
        int statusPegawai = int.parse(row[5]!.value!.toString());
        String full_nip = row[4]!.value!.toString();
        String old_nip = row[3]!.value!.toString();

        print("LOG ${i} : 1");
        User user = User(username: username, pwd: hashedPass, is_active: is_active);
        var result = await tx.execute(r'INSERT INTO "user" VALUES($1,$2,$3) RETURNING *',parameters: [
          user.username,
          user.pwd,
          user.is_active
        ]);

        print("LOG ${i}: 2");

        if(result.isEmpty){
          continue;
        }

        print("LOG ${i}: 3");

        //add role to user
        var result2 = await tx.execute(r'INSERT INTO user_role_bridge VALUES($1,$2) RETURNING *',parameters: [
          "PEGAWAI",
          username
        ]);

        String uuid = Uuid().v1();

        //insert pegawai_data
        var pegawai = Pegawai(
          uuid: uuid,
          fullname: fullname,
          fullname_with_title: fullname_with_title,
          username: username, 
          status_pegawai: statusPegawai, 
          jabatan: jabatanPegawai,
          nip: full_nip,
          old_nip: old_nip
        );

        var result3 = await tx.execute(r'INSERT INTO pegawai VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING uuid',parameters: [
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

        print("SUCCESS ${fullname_with_title}");
        if(result3.isEmpty){
          continue;
        }

      } catch(err){
        continue;
      }
    }
  });
  print("Success");
}


Pool prepareConnection() {
    try{
      String host = Platform.environment["dbhost"]??"localhost";
      String databaseName = Platform.environment["dbname"]??"sisolaki";
      String user = Platform.environment["dbuser"]??"postgres";
      String password = Platform.environment["dbpassword"]??"taufiq1729";
      Endpoint endpoint = Endpoint(
        host: host, 
        database: databaseName,
        username: user,
        password: password
      );
      return Pool.withEndpoints(
        [endpoint],
        settings: PoolSettings(
          maxConnectionCount: 3,
          connectTimeout: Duration(seconds: 10),
          sslMode: SslMode.disable)
          );
    } catch(e){
      throw Exception(e);
    }
}