// import 'package:flutter/material.dart';
// import 'package:connectivity/connectivity.dart';


// class Connection {
//   final connectivity = Connectivity();


//   Future<bool> Check(dynamic context) async {
//     var connectivityResult = await connectivity.checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       // No internet connection
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext contextt) {
//             return AlertDialog(
//               content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "تحقق من إتصال الإنترنت ",
//                     style: TextStyle(fontFamily: "Montserrat", fontSize: 20),
//                   ),
//                   Icon(Icons.signal_wifi_statusbar_connected_no_internet_4)
//                 ],
//               ),
//               actions: [
                
//                 FloatingActionButton(
//                   child: Text('نعم'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           });
//       return false;
//     } else if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       // Connected to either mobile data or Wi-Fi
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
