import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String houeOffset = data['utc_offset'].substring(1, 3);
      String minuteOffset = data['utc_offset'].substring(4);

      DateTime now = DateTime.parse(datetime).add(Duration(
        hours: int.parse(houeOffset), 
        minutes: int.parse(minuteOffset)
      ));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);
    } catch (e) {
      // ignore: avoid_print
      print('cought error: $e');
      time = "Could not get time data";
    }
  }
}
