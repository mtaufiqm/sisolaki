import 'dart:io';

import "package:postgres/postgres.dart";


class MyConnectionPool{
  static String dbHost = "localhost";
  static String dbName = "localhost";
  static String dbUser = "localhost";
  static String dbPassword = "localhost";
  late Pool connectionPool;
  MyConnectionPool(){
    try{
      String host = Platform.environment["dbhost"]??MyConnectionPool.dbHost;
      String databaseName = Platform.environment["dbname"]??MyConnectionPool.dbName;
      String user = Platform.environment["dbuser"]??MyConnectionPool.dbUser;
      String password = Platform.environment["dbpassword"]??MyConnectionPool.dbPassword;
      Endpoint endpoint = Endpoint(host: host, database: databaseName,username: user,password: password);
      connectionPool = Pool.withEndpoints([endpoint],settings: PoolSettings(maxConnectionCount: 25,connectTimeout: Duration(seconds: 5),sslMode: SslMode.disable));
    } catch(e){
      print(e);
    }
  }

  Future<void> closeConnectionPool() async{
    await this.connectionPool.close();
  }
}