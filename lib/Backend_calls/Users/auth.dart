import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  var dio = Dio();
  login(String email, String password) async {
    try{
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      FormData formData = FormData.fromMap(
          {
            'username': email,
            'password': password
          }
      );
      Response response = await dio.post('http://10.0.2.2:8000/users/login', data: formData);
      print(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', response.data["access_token"]);
      Map<String, dynamic> data = Jwt.parseJwt(response.data["access_token"]);

      print(response.data);

      return response.data;
    }
    catch (e){
      print(e);
    }
  }
}