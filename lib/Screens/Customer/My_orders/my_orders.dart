import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Customers/get_order.dart';
import 'package:frontend/Screens/Customer/Order_repair/rate_technician.dart';

import '../../../Backend_calls/Customers/get_orders.dart';
import '../customer.dart';
import '../../Users/profile.dart';

class Orders {
  String date;
  String technician;
  String status;

  Orders({required this.date, required this.technician, required this.status});
}

class MyOrdersScreen extends StatefulWidget {
  final List<Order> orders;

  const MyOrdersScreen({Key? key, required this.orders}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final List colors = [Color(0xFF1E5F74), Color(0xFF133B5C)];

  int _selectedIndex = 0;
  int _selectedId = 0;
  late String _employeeEmail;

  late List<Order> orders = widget.orders;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF133B5C),
          height: size.height,
          child: Column(
            children: [
              Profile(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  ElevatedButton(

                    onPressed: orders[_selectedIndex].status == "accepted"
                        ? null
                        : () async {
                      var response = await getOrder()
                          .getOrderFunc(_selectedId);
                      Map<String, dynamic> response_json =
                      json.decode(response);
                      _employeeEmail = response_json["employee_email"].toString();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RateTechnicianScreen(email: _employeeEmail,)));
                          },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 60),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Rate technician",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFF133B5C)),
                    child: SizedBox(
                      height: size.height * 0.5,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: orders.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: index % 2 == 0
                                ? Color(0xFF1E5F74)
                                : Color(0xFFFCDAB7),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ListTile(
                                selected: index == _selectedIndex,
                                selectedTileColor: Color(0xffc8a2c8),
                                selectedColor: Color(0xFFFCDAB7),
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    _selectedId = orders[_selectedIndex].id;
                                    print(_selectedId);
                                  });
                                },
                                onLongPress: () async {
                                  _selectedIndex = index;
                                  _selectedId = orders[_selectedIndex].id;
                                  print(_selectedId);
                                  var response = await getOrder()
                                      .getOrderFunc(_selectedId);
                                  Map<String, dynamic> response_json =
                                      json.decode(response);
                                  print(response_json);
                                  print(response_json["Orders"]["status"]);
                                  print(response_json["employee_name"]);
                                  setState(() {
                                    if (response_json["employee_name"] == null){
                                      response_json["employee_name"] = "Unassigned";
                                      response_json["employee_email"] = "Unassigned";
                                    }
                                    _employeeEmail = response_json["employee_email"].toString();
                                    print(_employeeEmail);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Center(
                                          child: Text(
                                            "Order information",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        content: Text(
                                            "Employee: ${response_json["employee_name"]}\n\n"
                                                "Email: ${response_json["employee_email"]}\n\n"
                                            "Issue: ${response_json["Orders"]["issue"]}\n\n"
                                            "Computer brand: ${response_json["Computers"]["brand"]}\n\n"
                                            "Computer model: ${response_json["Computers"]["model"]}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        backgroundColor: Color(0xFF133B5C),
                                      ),
                                    );
                                  });
                                },
                                horizontalTitleGap: 30,
                                leading: Text(
                                  orders[index].date,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Text(
                                  orders[index].status,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
