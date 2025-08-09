import 'dart:io';

import 'package:bpssulsel/helper/datetime_helper.dart';
import 'package:dart_frog/dart_frog.dart';

import "package:timezone/data/latest.dart" as tz;
import "package:timezone/standalone.dart" as tz;


Future<HttpServer> run(Handler handler,InternetAddress ip,int port) async {
  tz.initializeTimeZones();
  await DatetimeHelper.initInstance();
  return serve(handler, ip, port);
}