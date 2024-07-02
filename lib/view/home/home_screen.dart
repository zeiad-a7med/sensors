import 'package:weather/main.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/alarm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather/view/home/components/info_card.dart';
import 'package:weather/view_model/services/cache_helper.dart';
import 'package:weather/view/home/components/custom_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // final controller = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mySocket = ref.read(socketProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0085FF),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              InfoCard(
                isTemp: true,
              ),
              InfoCard(
                isTemp: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // if (CacheHelper.getData(key: 'disalert_code') == null) {
                        //   showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //         title: Text('Error'),
                        //         content: Text('Please Connect to the server'),
                        //         actions: [
                        //           TextButton(
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //             child: Text('OK'),
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   );
                        // } else {
                        //   ref.read(socketProvider.notifier).sendMessage(
                        //       event: 'disalert_code',
                        //       message:
                        //           CacheHelper.getData(key: 'disalert_code'));
                        // }
                        DatabaseReference _databaseReference;
                        _databaseReference = FirebaseDatabase.instance
                            .reference()
                            .child('sensors')
                            .child('Risk');
                        _databaseReference.set(1).then((_) {
                          print('Risk value updated successfully');
                        }).catchError((error) {
                          print('Failed to update risk value: $error');
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                          child: Text(
                            'Disalarm',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (CacheHelper.getData(key: 'open_window_code') ==
                            null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please Connect to the server'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          ref.read(socketProvider.notifier).sendMessage(
                              event: 'open_window_code',
                              message:
                                  CacheHelper.getData(key: 'open_window_code'));
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 9, 0, 0),
                          child: Text(
                            'Open Window',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
