import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Admin/orders_calls.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/constants.dart';
import '../admin.dart';
import '../../Users/profile.dart';
import '../../../Backend_calls/Employees/get_repairs.dart';

class assignEmployeeScreen extends StatefulWidget {
  final List<User_info> users;
  final order_id;

  const assignEmployeeScreen(
      {Key? key, required this.users, required this.order_id})
      : super(key: key);

  @override
  _assignEmployeeScreenState createState() => _assignEmployeeScreenState();
}

class _assignEmployeeScreenState extends State<assignEmployeeScreen> {
  int _selectedIndex = 0;
  String _selectedEmail = "";
  late List<User_info> users = widget.users;
  late var order_id = widget.order_id;

  late bool back;

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

  @override
  Widget build(BuildContext context) {
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
              Profile(email: response.toString()),
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
                        itemCount: users.length,
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
                                    _selectedEmail =
                                        users[_selectedIndex].email;
                                    print(_selectedEmail);
                                  });
                                },
                                horizontalTitleGap: 30,
                                title: Text(
                                  users[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle:Text(
                                  users[index].email,
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
                    onPressed: () {
                      assignEmployee().assign_employee(_selectedEmail, order_id);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 70),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Assign selected employee",
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