import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order{
  String id;
  String date;
  String status;

  Order(this.id, this.date, this.status);
}


class getRepairs with ChangeNotifier{
  var dio = Dio();
  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio.get('http://10.0.2.2:8000/employee/getRepairs');

      late List<Order> orders = [];

      for (var item in response.data){
        var order = Order(item["Orders"]["id"], item["Orders"]["date_created"], item["Orders"]["status"]);
        orders.add(order);
        print(item["Orders"]["date_created"]);
      }
      for (var item in orders){
        print(item);
      }

      return orders;

    }
    catch (e) {
      print(e);
    }
  }
}