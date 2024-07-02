import 'package:weather/main.dart';
import 'package:weather/core/alarm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:weather/view_model/services/cache_helper.dart';

class MySocket extends StateNotifier<bool> {
  late final String serverUrl;
  late final String serverIP;
  late final String serverPORT;
  late io.Socket socket;

  MySocket() : super(false);

  void connectToSocket({required String serverIP, required String serverPORT}) {
    serverUrl = 'http://$serverIP:$serverPORT';
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // print('connecting');
    socket.connect();

    socket.onConnect((_) {
      print('Connected to the socket server');
      state = true;
    });
    socket.onDisconnect((_) {
      
      state = false;
    });
    socket.on('message', (data) {
      if (data == CacheHelper.getData(key: 'alert_code') &&
          CacheHelper.getData(key: 'alert_code') != null) {
        Alarm.showBigTextNotification(
            title: "Tempreture Alert",
            body: '',
            fln: flutterLocalNotificationsPlugin);
      }
    });

    socket.onConnectError((data) {
      
    });
  }

  void disconnect() {
    socket.disconnect();
    state = false;
  }

  void sendMessage({required String event, required String message}) {
    socket.emit(event, message);
  }

  bool isActive() {
    return socket.active;
  }
}
