import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Rating {
  int id;
  String employee_email;
  String employee_name;
  double rating;
  String comment;

  Rating(this.id, this.employee_email, this.employee_name, this.rating, this.comment);
}

class getRatings with ChangeNotifier {
  var dio = Dio();

  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
      await dio.get(url + '/customer/getRatings');

      print(response);

      late List<Rating> ratings = [];

      for (var item in response.data) {
        var order = Rating(item["Ratings"]["id"], item["employee_email"], item["employee_name"],
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

class deleteRating{
  var dio = Dio();

  delete_rating(int rating_id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio
          .delete(url + '/customer/removeRating/$rating_id');

      print(response);

      return response;
    } catch (e) {
      print(e);
    }
  }
}
