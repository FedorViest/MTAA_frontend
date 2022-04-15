import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Order {
  String id;
  String date;
  String status;
  String issue;
  String brand;
  String model;
  int year_made;
  String customer_email;

  Order(this.id, this.date, this.status, this.issue, this.brand, this.model,
      this.year_made, this.customer_email);
}

class getRepairs with ChangeNotifier {
  var dio = Dio();

  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
          await dio.get(url + '/employee/getRepairs');

      late List<Order> orders = [];

      for (var item in response.data) {
        var order = Order(
            item["Orders"]["id"],
            item["Orders"]["date_created"],
            item["Orders"]["status"],
            item["Orders"]["issue"],
            item["Computers"]["brand"],
            item["Computers"]["model"],
            item["Computers"]["year_made"],
            item["customer_email"]);
        orders.add(order);
        print(item["Orders"]["date_created"]);
        print(item["Computers"]["brand"]);
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
