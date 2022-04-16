import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Admin/manage_employees.dart';
import 'package:frontend/Screens/Admin/Manage_employees/add_employee.dart';
import 'package:frontend/Screens/Customer/My_orders/my_orders.dart';
import 'package:frontend/Screens/Customer/Order_repair/rate_technician.dart';

import '../../../Backend_calls/Admin/orders_calls.dart';
import '../../../Utils/constants.dart';
import '../../Customer/customer.dart';
import '../../Users/profile.dart';
import 'change_employee.dart';

class Employee {
  String name;
  double rating;

  Employee({required this.name, required this.rating});
}

class ManageEmployeeScreen extends StatefulWidget {
  final List<User_info> employees;

  const ManageEmployeeScreen(
      {Key? key, required this.employees})
      : super(key: key);

  @override
  _ManageEmployeeScreenState createState() => _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends State<ManageEmployeeScreen> {
  int _selectedIndex = 0;
  String _selectedEmail = "";
  String _selectedName = "";
  late List<User_info> employees = widget.employees;

  var response = "";

  @override
  void initState(){
    super.initState();
    asyncMethod();
  }

  asyncMethod() async{
    response = await getProfileInfo();
    setState(() {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: Container(
        color: Color(0xFF133B5C),
        height: size.height,
        child: Column(
          children: [
            response.toString()=="" ? const CircularProgressIndicator():
            Profile(email: response.toString()),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                Container(
                  width: size.width * 0.9,
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xFF133B5C),
                  ),
                  child: SizedBox(
                    height: size.height * 0.4,
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
                                  _selectedEmail = employees[_selectedIndex].email;
                                  _selectedName = employees[_selectedIndex].name;
                                  print(_selectedEmail);
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
                SizedBox(height: size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    deleteEmployee().delete_employee(_selectedEmail);
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
                SizedBox(height: size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    print(_selectedName);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeEmployeeScreen(employeeName: _selectedName, employeeEmail: _selectedEmail)));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60),
                      primary: Color(0xFF1E5F74)),
                  child: const Text(
                    "Change employee",
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
    );
  }
}
