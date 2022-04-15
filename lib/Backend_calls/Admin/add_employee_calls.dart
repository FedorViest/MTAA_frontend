import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class addEmployee{
  var dio = Dio();

  add_employee(String name, String password, String email, String skills) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio
          .post(url + '/admin/addEmployee', data: {
        "name": name,
        "password": password,
        "email": email,
        "position": "employee",
        "skills": skills,
      });

      print(response);

      return response;
    } catch (e) {
      print(e);
    }
  }
}
