import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Rating {
  String customer_email;
  String employee_email;
  double rating;
  String comment;

  Rating(this.customer_email, this.employee_email, this.rating, this.comment);
}

class getRatings with ChangeNotifier {
  var dio = Dio();

  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
          await dio.get(url + '/admin/getRatings');

      print(response);

      late List<Rating> ratings = [];

      for (var item in response.data) {
        var order = Rating(item["customer_email"], item["employee_email"],
            item["Ratings"]["rating"], item["Ratings"]["comment"]);
        ratings.add(order);
        print(item["employee_email"]);
      }
      for (var item in ratings) {
        print(item);
      }

      return ratings;
    } catch (e) {
      print(e);
    }
  }
}
