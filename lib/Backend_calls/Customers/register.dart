import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register with ChangeNotifier {
  var dio = Dio();

  register(String name, String email, String password) async {
    try {
      Response response = await dio
          .post('http://10.0.2.2:8000/customer/registration', data: {
        "name": name,
        "password": password,
        "email": email,
        "position": "customer"

      });
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400){
        return e;
      }
    }
  }
}
