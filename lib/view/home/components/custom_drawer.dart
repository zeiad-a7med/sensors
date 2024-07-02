import 'package:weather/main.dart';
import 'package:weather/Api/Api.dart';
import 'package:flutter/material.dart';
import 'package:weather/Api/socket.dart';
import 'package:weather/config/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/view/login/pages/login_view.dart';
import 'package:weather/config/widgets/custom_form_field.dart';
import 'package:weather/view_model/services/cache_helper.dart';
import 'package:weather/config/widgets/border_rounded_button.dart';

// import 'package:weather/view/socket_view.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var ipController =
        TextEditingController(text: CacheHelper.getData(key: 'ip') ?? '');
    var portController =
        TextEditingController(text: CacheHelper.getData(key: 'port') ?? '');
    var alertController = TextEditingController(
        text: CacheHelper.getData(key: 'alert_code') ?? '');
    var disalertController = TextEditingController(
        text: CacheHelper.getData(key: 'disalert_code') ?? '');
    var openWindowController = TextEditingController(
        text: CacheHelper.getData(key: 'open_window_code') ?? '');
    final mySocket = ref.read(socketProvider);
    // MySocket mySocket = MySocket();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0085FF),
            ),
            child: Container(
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 40,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "${CacheHelper.getData(key: 'email')}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            // color: Colors.amber,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: ipController,
                    hint: "enter device IP",
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter device IP";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: portController,
                    hint: "enter device PORT",
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter device PORT";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: alertController,
                    hint: "enter alert code",
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter alert code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: disalertController,
                    hint: "enter disalert code",
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter disalert code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: openWindowController,
                    hint: "enter open window code",
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter open windows code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BorderRoundedButton(
                    title: "connect",
                    color: Constants.theme.primaryColor,
                    fontSize: 20,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CacheHelper.saveData(
                          key: 'ip',
                          value: ipController.text,
                        );
                        CacheHelper.saveData(
                          key: 'port',
                          value: portController.text,
                        );
                        CacheHelper.saveData(
                          key: 'open_window_code',
                          value: openWindowController.text,
                        );
                        CacheHelper.saveData(
                          key: 'alert_code',
                          value: alertController.text,
                        );
                        CacheHelper.saveData(
                          key: 'disalert_code',
                          value: disalertController.text,
                        );
                        ref.read(socketProvider.notifier).connectToSocket(
                            serverIP: ipController.text,
                            serverPORT: portController.text);
                        ref.read(socketProvider.notifier).sendMessage(
                            event: 'open_window_code',
                            message: openWindowController.text);
                        ref.read(socketProvider.notifier).sendMessage(
                            event: 'alert_code', message: alertController.text);
                        ref.read(socketProvider.notifier).sendMessage(
                            event: 'disalert_code',
                            message: disalertController.text);
                        // mySocket.connectToSocket(serverIP: ipController.text, serverPORT: portController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BorderRoundedButton(
                    title: "Disconnect",
                    color: Constants.theme.primaryColor,
                    fontSize: 20,
                    onPressed: () async {
                      // mySocket.disconnect();
                      ref.read(socketProvider.notifier).disconnect();

                      CacheHelper.removeData(key: 'ip');
                      CacheHelper.removeData(key: 'port');
                      CacheHelper.removeData(key: 'open_window_code');
                      CacheHelper.removeData(key: 'alert_code');
                      CacheHelper.removeData(key: 'disalert_code');
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("logout"),
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {},
            ),
            onTap: () async {
              await CacheHelper.clearAllData().then((succes) {
                if (succes) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
