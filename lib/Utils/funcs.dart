import 'package:flutter/material.dart';

import '../Backend_calls/Employees/get_repairs.dart';
import '../Screens/Admin/admin.dart';
import '../Screens/Customer/customer.dart';
import '../Screens/Employee/employee.dart';

Future<bool> showCorrectDialog(BuildContext context, String text, String screen) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFCDAB7),
        title: Text(text),
        alignment: Alignment.center,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              if(screen == "customer"){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CustomerScreen()));
              }
              else if(screen == "employee")
                {
                  var response2 = await getRepairs().getInfo();
                  print("RESPONSE ${response2}");
                  response2 ??= [Repair("", "NO", "REPAIRS", "", "", "", 0, "")];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmployeeScreen(repairs: response2)));
                }
              else if(screen == "admin")
              {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => AdminScreen()));
              }
              },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}