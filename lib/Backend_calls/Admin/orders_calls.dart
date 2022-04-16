import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Order {
  int id;
  String status;
  String date;
  String brand;
  String model;
  String year;
  String customer_email;
  String issue;

  Order(this.id, this.status, this.date, this.brand, this.model, this.year, this.customer_email, this.issue);
}

class User_info {
  String name;
  String email;
  String reg_date;
  String position;
  String skills;

  User_info(this.name, this.email, this.reg_date, this.position, this.skills);
}

class assignEmployeeOut {
  String email;
  String order_id;

  assignEmployeeOut(this.email, this.order_id);
}

class getOrders with ChangeNotifier {
  var dio = Dio();

  getOrdersFunc() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio.get(url + '/admin/getNullOrders');

      late List<Order> orders = [];

      for (var item in response.data) {
        print(item["id"]);
        var order = Order(item["Orders"]["id"], item["Orders"]["status"],
            item["Orders"]["date_created"], item["Computers"]["brand"], item["Computers"]["model"],
            item["Computers"]["year_made"], item["user_email"], item["Orders"]["issue"]);
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

class getAllEmployees with ChangeNotifier {
  var dio = Dio();

  Future<dynamic> getInfo() async {
    try {
      // vsade okrem register a login
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      print("penis");
      Response response =
          await dio.get(url + '/admin/getAllEmployees');

      late List<User_info> users = [];

      print(response.data);
      for (var item in response.data) {
        var user = User_info(item["name"], item["email"], item["registration_date"], item["position"], item["skills"]);
        users.add(user);
      }

      return users;
    } catch (e) {
      print(e);
    }
  }
}

class assignEmployee with ChangeNotifier {
  var dio = Dio();

  Future<dynamic> assign_employee(email, order_id) async {
    try {
      // vsade okrem register a login
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
          await dio.put(url + '/admin/assignEmployee/$email/$order_id');

      return response;
    } catch (e) {
      print(e);
    }
  }
}
