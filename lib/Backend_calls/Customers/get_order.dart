import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class OneOrder{
  int id;
  String issue;
  String brand;
  String model;
  String employee_email;

  OneOrder(this.id, this.issue, this.brand, this.model, this.employee_email);
}

class getOrder with ChangeNotifier{
    var dio = Dio();
    getOrderFunc(id) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final access_token = prefs.getString("access_token") ?? '';
        dio.options.headers["authorization"] = "Bearer " + access_token;

        Response response =
        await dio.get(url + '/customer/getOrders/$id');

        print(response);

        return response.toString();

      }
      catch (e) {
        print(e);
      }
    }
}