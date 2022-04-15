

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class AddRating with ChangeNotifier{
  add_rating(email, rating, comment) async{
    var dio = Dio();
    try{
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      print(email);
      print(rating);
      print(comment);

      Response response =
      await dio.post(url + '/customer/addRating', data: {
        "employee_email": email,
        "rating_stars": rating,
        "comment": comment
      });

      return response;
    }
    catch (e){
      print(e);
    }
  }
}