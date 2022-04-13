import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'profile.dart';
import '../Backend_calls/Employees/get_repairs.dart';

class EmployeeScreen extends StatefulWidget {

  final List<Order> orders;
  const EmployeeScreen({Key? key, required this.orders}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen>{

  int _selectedIndex = 0;
  late List<Order> orders = widget.orders;

  @override
  Widget build(BuildContext context) {

    print(orders);
    //print("Date: ${response["Orders"]["date_created"]}, Status: ${response["Orders"]["status"]}");

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
                      onPressed: (orders[_selectedIndex].status == "finished")? null: () {
                        setState(() {
                            orders[_selectedIndex].status = "finished";
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