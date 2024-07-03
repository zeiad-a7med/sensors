import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Alarm {
//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings =
//         new InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static Future showBigTextNotification(
//       {var id = 0,
//       required String title,
//       required String body,
//       var payload,
//       required FlutterLocalNotificationsPlugin fln}) async {
//          AndroidAlarmManager.oneShot(
//       Duration(seconds: 10),
//       0, // Ensure the ID is unique
//       // () async {

//       // },
//       notification(
//         id: id,
//         title: title,
//         body: body,
//         payload: payload,
//         fln: fln,
//       ),
//       exact: true,
//       wakeup: true,
//     );
    
//   }
//   static notification(
//     {var id = 0,
//       required String title,
//       required String body,
//       var payload,
//       required FlutterLocalNotificationsPlugin fln}
//   ) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         new AndroidNotificationDetails(
//       'alarm_channel_id_1',
//       'Alarm Channel',
//       // 'Channel for alarm notifications',
//       playSound: true,
//       autoCancel: false,
//       enableLights: true,
//       enableVibration: true,
//       sound: RawResourceAndroidNotificationSound('notification'),
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     var not = NotificationDetails(android: androidPlatformChannelSpecifics);
//      await fln.show(0, title, body, not);
//   }
      
// }



class Alarm {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'alarm_channel_id_1',
      'Alarm Channel',
      // 'Channel for alarm notifications',
      playSound: true,
      autoCancel: false,
      enableLights: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }
}


