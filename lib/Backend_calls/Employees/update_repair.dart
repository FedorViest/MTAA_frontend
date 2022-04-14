import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class updateRepair with ChangeNotifier{
  var dio = Dio();
  getInfo(id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio.put('http://10.0.2.2:8000/employee/updateOrderState/$id', data: {
        "status": "finished"
      });
      print('http://10.0.2.2:8000/employee/updateOrderState/$id');

      return response;
    }
    catch (e) {
      print(e);
    }
  }
}