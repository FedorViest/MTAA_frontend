import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Admin/computer_calls.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:frontend/Screens/Admin/Manage_computers/add_computer.dart';
import 'package:frontend/Screens/Admin/Manage_orders/assignEmployee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Backend_calls/Admin/orders_calls.dart';
import '../../../Backend_calls/Users/profile_pictures.dart';
import '../../../Utils/constants.dart';
import '../../Users/profile.dart';
import '../../../Backend_calls/Employees/get_repairs.dart';

class ManageComputersScreen extends StatefulWidget {
  final List<Computer> computers;

  const ManageComputersScreen({Key? key, required this.computers})
      : super(key: key);

  @override
  _ManageComputersScreenState createState() => _ManageComputersScreenState();
}

class _ManageComputersScreenState extends State<ManageComputersScreen> {
  late List<Computer> computers = widget.computers;

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
                      height: size.height * 0.5,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: computers.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: index % 2 == 0
                                ? Color(0xFF1E5F74)
                                : Color(0xFFFCDAB7),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ListTile(
                                selectedTileColor: Color(0xffc8a2c8),
                                selectedColor: Color(0xFFFCDAB7),
                                horizontalTitleGap: 30,
                                leading: Text(
                                  computers[index].brand,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Text(
                                  computers[index].model +
                                      " " +
                                      computers[index].year_made,
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => AddComputerScreen()));
                      },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 70),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Add new computer",
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
