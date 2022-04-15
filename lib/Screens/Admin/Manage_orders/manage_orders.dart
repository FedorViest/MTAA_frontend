import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:frontend/Screens/Admin/Manage_orders/assignEmployee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Backend_calls/Admin/orders_calls.dart';
import '../../Users/profile.dart';
import '../../../Backend_calls/Employees/get_repairs.dart';

class ManageOrdersScreen extends StatefulWidget {
  final List<Order> orders;

  const ManageOrdersScreen(
      {Key? key, required this.orders})
      : super(key: key);

  @override
  _ManageOrdersScreenState createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  int _selectedIndex = 0;
  int _selectedId = 0;
  late List<Order> orders = widget.orders;

  late bool back;

  @override
  Widget build(BuildContext context) {
    print(orders);
    //print("Date: ${response["Orders"]["date_created"]}, Status: ${response["Orders"]["status"]}");

    Size size = MediaQuery.of(context).size;

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
                  SizedBox(height: size.height * 0.1),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF133B5C),
                    ),
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
                  SizedBox(height: size.height * 0.06),
                  ElevatedButton(
                    onPressed:
                      (orders[_selectedIndex].status == "ORDERS") ? null
                          : () async {
                                print("penis");
                               var response = await getAllEmployees().getInfo();
                               print(response);
                                response ??= [User_info("NO", "EMPLOYEES")];
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => assignEmployeeScreen(
                                        users: response,
                                        order_id: _selectedId,
                                      )));
                            },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 70),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "View Employees",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
