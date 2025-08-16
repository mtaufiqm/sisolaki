import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart';
class DatetimeHelper {
  static bool isInitialized = false;
  static late Location makassarLocation;


  static Future<void> initInstance() async {
    if(isInitialized == false){
      //initialization process
      await tz.initializeTimeZone();
      makassarLocation = tz.getLocation("Asia/Makassar");

      //set initialized to true;
      isInitialized = true;
    }
  }

  static String getCurrentMakassarTime(){
    return tz.TZDateTime.now(makassarLocation).toIso8601String();
  }

  static DateTime parseMakassarTime(String makassarTime) {
    return tz.TZDateTime.parse(DatetimeHelper.makassarLocation,makassarTime);
  }
}

Map<String,String> monthNameMap = {
  "01":"Januari",
  "02":"Februari",
  "03":"Maret",
  "04":"April",
  "05":"Mei",
  "06":"Juni",
  "07":"Juli",
  "08":"Agustus",
  "09":"September",
  "10":"Oktober",
  "11":"November",
  "12":"Desember"
};