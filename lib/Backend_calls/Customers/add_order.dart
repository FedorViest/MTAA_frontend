import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOrder with ChangeNotifier{
  var dio = Dio();
  add_order(brand, model, year, issue) async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;

      year = int.parse(year);
      print(brand.runtimeType);
      print(model.runtimeType);
      print(year.runtimeType);
      print(issue.runtimeType);

      Response response = await dio.post(url + '/customer/addOrder', data: {
        "pc_brand": brand,
        "pc_model": model,
        "pc_year": year,
        "issue": issue
      });

      print(response);
      return response;
    }
    catch (e){
      print(e);
    }
  }
}