import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Screens/add_employee.dart';
import 'package:frontend/Screens/my_orders.dart';
import 'package:frontend/Screens/rate_technician.dart';

import 'customer.dart';
import 'profile.dart';

class Employee {
  String name;
  double rating;

  Employee({required this.name, required this.rating});
}

class ManageEmployeeScreen extends StatefulWidget {
  @override
  _ManageEmployeeScreenState createState() => _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends State<ManageEmployeeScreen> {
  int _selectedIndex = 0;

  final List employees = [
    Employee(name: "Robert", rating: 0.5),
    Employee(name: "a", rating: 1),
    Employee(name: "R", rating: 2),
    Employee(name: "obert", rating: 2.5),
    Employee(name: "b", rating: 3),
    Employee(name: "c", rating: 3),
    Employee(name: "d", rating: 4),
    Employee(name: "e", rating: 4.5),
    Employee(name: "f", rating: 0),
    Employee(name: "g", rating: 1),
    Employee(name: "Robert", rating: 1),
    Employee(name: "Robert", rating: 2),
    Employee(name: "Robert", rating: 3),
  ];

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
                  SizedBox(height: size.height * 0.05),
                  Container(
                    width: size.width * 0.9,
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      color: Color(0XFF1D2D50),
                    ),
                    child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: employees.length,
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
                                  });
                                },
                                horizontalTitleGap: 30,
                                leading: Text(
                                  employees[index].name,
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
                  SizedBox(height: size.height * 0.1),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyOrdersScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 60),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Delete employee",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddEmployeeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 60),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Add employee",
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
