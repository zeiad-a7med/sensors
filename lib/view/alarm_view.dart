// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// dart
// Copy

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Alarm App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AlarmScreen(),
//     );
//   }
// }

// class AlarmScreen extends StatefulWidget {
//   @override
//   _AlarmScreenState createState() => _AlarmScreenState();
// }

// class _AlarmScreenState extends State<AlarmScreen> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   TimeOfDay selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     selectedTime = TimeOfDay.now();
//     initializeNotifications();
//   }

//   void initializeNotifications() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> scheduleNotification() async {
//     final DateTime now = DateTime.now();
//     final DateTime scheduledTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );

//     if (scheduledTime.isBefore(now)) {
//       showSnackBar('Invalid time selected');
//       return;
//     }

//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alarm_notification',
//       'Alarm Notification',
//       'Channel for alarm notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('alarm_sound'),
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Alarm',
//       'Wake up!',
//       scheduledTime,
//       platformChannelSpecifics,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );

//     showSnackBar('Alarm set for ${selectedTime.format(context)}');
//   }

//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Alarm App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Select alarm time:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () async {
//                 final TimeOfDay selected = await showTimePicker(
//                   context: context,
//                   initialTime: selectedTime,
//                 );
//                 if (selected != null) {
//                   setState(() {
//                     selectedTime = selected;
//                   });
//                 }
//               },
//               child: Text('Set Time'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: scheduleNotification,
//               child: Text('Set Alarm'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }