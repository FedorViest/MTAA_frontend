import 'package:flutter/material.dart';

import 'profile.dart';

class Order{
  String date;
  String technician;
  String status;

  Order({required this.date, required this.technician, required this.status});
}

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen>{

  int _selectedIndex = 0;
  String? _state;

  final List orders = [
    Order(date: "2020-02-28", technician: "Robert", status: "Pending"),
    Order(date: "2019-01-27", technician: "a", status: "Finished"),
    Order(date: "2018-01-27", technician: "R", status: "Finished"),
    Order(date: "2022-01-27", technician: "obert", status: "Finished"),
    Order(date: "2021-01-27", technician: "b", status: "Finished"),
    Order(date: "2020-01-27", technician: "c", status: "Finished"),
    Order(date: "2020-01-27", technician: "d", status: "Finished"),
    Order(date: "2020-01-27", technician: "e", status: "Finished"),
    Order(date: "2020-01-27", technician: "f", status: "Finished"),
    Order(date: "2020-01-27", technician: "g", status: "Finished"),
    Order(date: "2020-01-27", technician: "Robert", status: "Finished"),
    Order(date: "2020-01-27", technician: "Robert", status: "Finished"),
    Order(date: "2020-01-27", technician: "Robert", status: "Finished"),
  ];

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
                  SizedBox(height: size.height * 0.1),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF133B5C),
                    ),
                    child:SizedBox(
                      height: size.height * 0.5,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: orders.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            color: index % 2 == 0 ? Color(0xFF1E5F74):Color(0xFFFCDAB7),
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
                                leading: Text(orders[index].date,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Text(orders[index].status,
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
                  SizedBox(height: size.height * 0.06),
                  ElevatedButton(
                      onPressed: (orders[_selectedIndex].status == "Finished")? null: () {
                        setState(() {
                            orders[_selectedIndex].status = "Pending";
                        });
                      },
                     style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 70), primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Finish selected repair",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
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