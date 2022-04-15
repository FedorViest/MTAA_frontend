import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Order {
  int id;
  String status;
  String date;

  Order(this.id, this.status, this.date);
}

class Users_info {
  String name;
  String email;

  Users_info(this.name, this.email);
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

      print(response);
      print("penis");

      late List<Order> orders = [];

      for (var item in response.data) {
        print(item["id"]);
        var order = Order(item["Orders"]["id"], item["Orders"]["status"],
            item["Orders"]["date_created"]);
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

class Users_profile with ChangeNotifier {
  var dio = Dio();

  Future<dynamic> getInfo() async {
    try {
      // vsade okrem register a login
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      print("penis");
      Response response =
          await dio.get('http://10.0.2.2:8000/admin/getAllEmployees');

      late List<Users_info> users = [];

      print(response.data);
      for (var item in response.data) {
        var user = Users_info(item["name"], item["email"]);
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
