// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:weather/Api/connection.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:weather/view_model/services/cache_helper.dart';

// // ignore_for_file: non_constant_identifier_names

// class Api {
//   BuildContext context;
//   Api({required this.context});
//   Connection con = new Connection();
// ////Admin operations
//   Future<Map> getData() async {
//     String Url ='http://${CacheHelper.getData(key: 'ip') ?? ''}:${CacheHelper.getData(key: 'port')??''}';
//     var response = await http.get(
//       Uri.parse(Url)
//     );
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print(response.statusCode);
//     }
//     return jsonDecode(response.body);
//   }


//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return connectivityResult != ConnectivityResult.none;
//   }
// }
