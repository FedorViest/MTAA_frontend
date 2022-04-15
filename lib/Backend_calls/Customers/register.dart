import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/constants.dart';

class Register with ChangeNotifier {
  var dio = Dio();

  register(String name, String email, String password) async {
    try {
      Response response = await dio
          .post(url + '/customer/registration', data: {
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
