import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:frontend/Screens/Admin/Manage_orders/assignEmployee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Backend_calls/Admin/orders_calls.dart';
import '../../../Backend_calls/Users/profile_pictures.dart';
import '../../../Utils/constants.dart';
import '../../../Backend_calls/Customers/get_order.dart';
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
  late String _employeeEmail;

  late bool back;

  var response = "";
  var img;
  var response_img;

  @override
  void initState(){
    super.initState();
    asyncMethod();
  }

  asyncMethod() async{
    img = await getProfilePicture();
    response_img = await getPictureResponse();
    response = await getProfileInfo();
    setState(() {});
  }

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
              response.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response.toString(), img: img, response_img: response_img),
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
                      height: size.height * 0.3,
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
                                          "Customer: ${orders[index].customer_email}\n\n"
                                              "Brand: ${orders[index].brand}\n\n"
                                              "Model: ${orders[index].model}\n\n"
                                              "Year of release: ${orders[index].year}\n\n"
                                              "Issue: ${orders[index].issue}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      backgroundColor: Color(0xFF133B5C),
                                    ),
                                  );
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
                      var response = await getAllEmployees().getInfo();
                      print(response);
                      response ??= [User_info("NO", "EMPLOYEES", "", "", "")];
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