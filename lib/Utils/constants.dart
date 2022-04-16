import 'package:flutter/material.dart';

import '../Backend_calls/Users/login_calls.dart';

const COLOR_CREAM = Color(0xFFFCDAB7);

const url = "https://fiit-mtaa-backend.herokuapp.com";

const ip = "10.10.10.10";

late String set_ip = ip;

RegExp regExp = RegExp(
  r'(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
);


getProfileInfo() async{
  var response = await Users().getInfo();

  return response["email"];
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