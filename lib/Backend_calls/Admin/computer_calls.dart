import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class Computer {
  int id;
  String brand;
  String model;
  String year_made;

  Computer(this.id, this.brand, this.model, this.year_made);
}

class getComputers with ChangeNotifier {
  var dio = Dio();

  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
      await dio.get(url + '/admin/getComputers');

      print(response);

      late List<Computer> computers = [];

      for (var item in response.data) {
        var computer = Computer(item["id"], item["brand"], item["model"], item["year_made"]);
        computers.add(computer);
      }
      for (var item in computers) {
        print(item);
      }

      return computers;
    } catch (e) {
      print(e);
    }
  }
}

class addComputer{
  var dio = Dio();

  add_computer(String brand, String model, String year_made) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response = await dio
          .post(url + '/admin/addComputer', data: {
        "brand": brand,
        "model": model,
        "year_made": year_made
      });

      print(response);

      return response;
    } catch (e) {
        return e;
    }
  }
}
