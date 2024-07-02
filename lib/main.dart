import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:weather/core/alarm.dart';
import 'package:weather/Api/socket.dart';
import 'package:weather/core/alarmFireBase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/view/splash/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:weather/view_model/services/cache_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey globalKey = GlobalKey();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// final socketProvider = StateNotifierProvider<SocketNotifier, dynamic>((ref) {
//   return SocketNotifier();
// });
final socketProvider = StateNotifierProvider<MySocket, bool>((ref) {
  return MySocket();
});
// final alarmProvider = StateNotifierProvider<AlarmNotify, bool>((ref) {
//   return AlarmNotify();
// });
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Alarm.initialize(flutterLocalNotificationsPlugin);
  await AlarmNotify().connect();
  await CacheHelper.init();
  await CacheHelper.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
    );
  }
}

// Future<void> scheduleAlarm() async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'alarm_channel_id',
//     'Alarm Channel',
//     'Channel for alarm notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//   );
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics,
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Alarm',
//     'Wake up!',
//     platformChannelSpecifics,
//     payload: 'notification_payload',
//   );
// }
