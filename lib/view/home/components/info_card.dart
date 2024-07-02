import 'package:get/get.dart';
import 'package:weather/main.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/alarm.dart';
import '../../../res/images/image_assets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather/view_model/controllers/home_controller.dart';

class InfoCard extends ConsumerStatefulWidget {
  final bool isTemp;
  InfoCard({super.key, required this.isTemp});

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends ConsumerState<InfoCard> {
  final hProvider = StateProvider<dynamic>((ref) {
    return "";
  });
  final cProvider = StateProvider<dynamic>((ref) {
    return "";
  });

  late DatabaseReference _databaseReference;
  late dynamic _stringValue = ''; // Holds the string value from Firebase
  Future<void> _initializeFirebase() async {
    if (widget.isTemp) {
      _databaseReference = FirebaseDatabase.instance.reference().child('c');
      _databaseReference.onValue.listen((event) {
        setState(() {
          _stringValue = event.snapshot.value ?? ''; // Update the string value
          ref.read(cProvider.notifier).state = event.snapshot.value ?? '';
        });
      });
    } else {
      _databaseReference = FirebaseDatabase.instance.reference().child('h');
      _databaseReference.onValue.listen((event) {
        setState(() {
          ref.read(hProvider.notifier).state = event.snapshot.value ?? '';
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 240,
      width: size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 180,
            margin: const EdgeInsets.only(bottom: 30),
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (widget.isTemp)
                          ? Color.fromRGBO(243, 128, 33, 1)
                          : Colors.blue.withOpacity(.7),
                      const Color.fromARGB(255, 125, 133, 139),
                      (widget.isTemp)
                          ? Color.fromRGBO(243, 128, 33, 1)
                          : Colors.blue,
                    ])),
          ),
          Positioned(
              top: 0,
              left: 10,
              child: Image.asset(
                (widget.isTemp)
                    ? 'assets/images/tempreature.png'
                    : 'assets/images/wet.png',
                height: 130,
                width: 130,
                fit: BoxFit.fill,
              )),
          Positioned(
            bottom: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(builder: (context, ref, _) {
                  dynamic val = (widget.isTemp)
                      ? ref.watch(cProvider)
                      : ref.watch(hProvider);
                  return Text(
                    '${val}',
                    style: const TextStyle(
                        height: 0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  );
                }),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  Utils.currentTime(),
                  style: TextStyle(
                      height: 0,
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(.1)],
                      // Adjust the stops to control the gradient area
                    ).createShader(bounds);
                  },
                  child: Consumer(builder: (context, ref, _) {
                    dynamic val = (widget.isTemp)
                        ? ref.watch(cProvider)
                        : ref.watch(hProvider);
                    return Text(
                      '${val} ${(widget.isTemp) ? '°C' : 'H'}',
                      style: const TextStyle(
                        fontSize: 40,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Initial color of the text
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white.withOpacity(.1)],
                  // Adjust the stops to control the gradient area
                ).createShader(bounds);
              },
              child: Image.asset(
                ImageAssets.windWave,
                height: 150,
                width: 200,
              ),
            ),
          )
        ],
      ),
    );
  }
}
