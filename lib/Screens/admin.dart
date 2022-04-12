import 'package:flutter/material.dart';
import 'package:frontend/Screens/employee_ratings.dart';
import 'package:frontend/Screens/manage_employees.dart';
import 'package:frontend/Screens/my_orders.dart';
import 'package:frontend/Screens/order_repair.dart';

import 'profile.dart';

class AdminScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
      child:Container(
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRatingScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
                  child: const Text(
                    "Employee Ratings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManageEmployeeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
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
    );
  }
}