import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Order{
  int id;
  String status;
  String date;

  Order(this.id, this.status, this.date);
}

class getOrders with ChangeNotifier{
  var dio = Dio();

  getOrdersFunc() async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
      await dio.get(url + '/customer/getOrders');

      print(response);

      late List<Order> orders = [];

      for (var item in response.data) {
        print(item["id"]);
        var order = Order(item["id"], item["status"], item["date_created"]);
        orders.add(order);
      }
      for (var item in orders) {
        print(item);
      }

      return orders;
    } catch (e) {
      print(e);
    }
  }
}