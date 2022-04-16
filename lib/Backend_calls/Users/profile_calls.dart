import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_info{
  String name;
  String email;

  Profile_info(this.name, this.email);
}


class Users_profile with ChangeNotifier {
  var dio = Dio();

  Future<dynamic> getInfo() async {
    try {
      // vsade okrem register a login
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio.get('http://10.0.2.2:8000/users/getInfo');

      late Profile_info profile_info = Profile_info(response.data["name"], response.data["email"]);

      return profile_info;
    } catch (e) {
      print(e);
    }
  }
}
