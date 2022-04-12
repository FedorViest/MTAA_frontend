import 'package:flutter/material.dart';
import 'package:frontend/Screens/my_orders.dart';
import 'package:frontend/Screens/order_repair.dart';

import 'profile.dart';

class CustomerScreen extends StatelessWidget {

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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderRepairScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
                  child: const Text(
                    "Order repair",
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
                  child: const Text(
                    "My orders",
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