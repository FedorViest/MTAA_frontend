import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users with ChangeNotifier{
  var dio = Dio();
  Future<dynamic>getInfo() async{
    try{
      // vsade okrem register a login
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio.get('http://10.0.2.2:8000/users/getInfo');
          print(response.data);
      print("Users ===>>>> ${access_token}");
      return response.data;
    }
    catch (e){
      print(e);
    }
  }
}