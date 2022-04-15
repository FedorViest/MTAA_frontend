import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Admin/orders_calls.dart';
import 'package:frontend/Screens/employee_ratings.dart';
import 'package:frontend/Screens/manage_employees.dart';
import 'package:frontend/Screens/manage_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Backend_calls/Admin/get_ratings.dart';
import 'login.dart';
import 'profile.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late bool back;

  Future<bool> _showMyDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCDAB7),
          title: const Text('Do you wish to logout?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close_outlined),
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.pop(context, true);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        back = await _showMyDialog();
        if (back) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        }
        return back;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E5F74),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Color(0xFF133B5C),
            child: Column(
              children: [
                Profile(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    ElevatedButton(
                      onPressed: () async {
                        var response2 = await getRatings().getInfo();
                        print("RESPONSE ${response2}");
                        response2 ??= [Rating("NO", "REPAIRS", 0, "")];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EmployeeRatingScreen(ratings: response2)));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Employee Ratings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      onPressed: () async {
                        var response2 = await getOrders().getOrdersFunc();
                        print("RESPONSE ${response2}");
                        response2 ??= [Order(0, "ORDERS", "NO")];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManageOrdersScreen(
                                orders: response2)));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Manage orders",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManageEmployeeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Manage employees",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
