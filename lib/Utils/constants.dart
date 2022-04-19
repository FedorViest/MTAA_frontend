import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Users/profile_pictures.dart';

import '../Backend_calls/Users/login_calls.dart';

const COLOR_CREAM = Color(0xFFFCDAB7);

const url = "https://fiit-mtaa-backend.herokuapp.com";

const ip = "192.168.73.132";

late String set_ip = ip;

RegExp regExp = RegExp(
  r'(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
);

RegExp ipExp = new RegExp(r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$", caseSensitive: false, multiLine: false);


getProfileInfo() async{
  var response = await Users().getInfo();

  return response["email"];
}

getPosition() async{
  var response = await Users().getInfo();

  return response["position"];
}

getProfilePicture() async{
  var response = await GetPicture().get_picture();

  return response;
}

getPictureResponse() async{
  var response = await GetPicture().getPictureResponse();
  print("RESPONSE RESPONSE");
  print(response);
  return response;
}


Future<bool> showMyDialog(context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}