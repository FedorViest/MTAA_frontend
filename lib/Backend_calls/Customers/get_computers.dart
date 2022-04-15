import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';


class Computers {
  int id;
  String brand;
  String model;
  String year_made;

  Computers(this.id, this.brand, this.model, this.year_made);
}

class getComputersCustomer with ChangeNotifier {
  var dio = Dio();

  getInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      Response response =
      await dio.get(url + '/customer/getComputers');

      print(response);

      late List<Computers> computers = [];

      for (var item in response.data) {
        var computer = Computers(item["id"], item["brand"], item["model"], item["year_made"]);
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