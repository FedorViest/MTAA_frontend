import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';


class GetPicture with ChangeNotifier{
  var dio = Dio();

  get_picture() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;
      Map<String, dynamic> data = Jwt.parseJwt(prefs.getString("access_token").toString());
      print(data);
      print(data["id"]);

      Map<String, String> auth = {
        'authorization' : "Bearer " + access_token,
      };

      ImageProvider img = await Image.network(url + "/users/getPicture/" + data["id"].toString(), headers: auth,).image;
      print("PICTURE");
      print(img);

      return img;
    }
    catch (e){
      print(e);
    }
  }

  getPictureResponse() async{
    try{
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString("access_token") ?? '';
      dio.options.headers["authorization"] = "Bearer " + access_token;
      Map<String, dynamic> data = Jwt.parseJwt(prefs.getString("access_token").toString());
      Response response = await dio.get(url + '/users/getPicture/' + data["id"].toString());

      return response;
    }
    catch (e){
      print(e);
    }
  }
}

class UploadPicture with ChangeNotifier {
  var dio = Dio();

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    print(file);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString("access_token") ?? '';
    dio.options.headers["authorization"] = "Bearer " + access_token;
    print("SOM TU");
    print(formData);
    var response = await dio.post(url + "/users/uploadPicture", data: formData);
    return response.data;
  }
}