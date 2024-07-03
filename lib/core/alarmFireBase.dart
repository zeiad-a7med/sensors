import 'package:weather/main.dart';
import 'package:flutter/services.dart';
import 'package:weather/core/alarm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:weather/view_model/services/cache_helper.dart';

class AlarmNotify extends StateNotifier<bool> {
  late final dynamic notify;
  

  AlarmNotify() : super(false);

  dynamic connect() async {

    DatabaseReference _databaseReference;
  _databaseReference = FirebaseDatabase.instance.reference().child('sensors').child('Risk');
      _databaseReference.onValue.listen((event) async {
        if(event.snapshot.value != null && event.snapshot.value == 2){
          Alarm.showBigTextNotification(
            title: "Tempreture Alert",
            body: '',
            fln: flutterLocalNotificationsPlugin);
          Alarm.showBigTextNotification(
            title: "Tempreture Alert",
            body: '',
            fln: flutterLocalNotificationsPlugin);
          Alarm.showBigTextNotification(
            title: "Tempreture Alert",
            body: '',
            fln: flutterLocalNotificationsPlugin);
          Alarm.showBigTextNotification(
            title: "Tempreture Alert",
            body: '',
            fln: flutterLocalNotificationsPlugin);
        }

              // await platform.invokeMethod('setAlarm', {"hour": 0, "minute": 0, "second":0});

      });
  }
  

}

