import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile.dart';
import '../Backend_calls/Employees/get_repairs.dart';

class EmployeeScreen extends StatefulWidget {
  final List<Order> orders;

  const EmployeeScreen({Key? key, required this.orders}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  int _selectedIndex = 0;
  int _selectedId = 0;
  late List<Order> orders = widget.orders;

  late bool back;

  Future<bool> _showMyDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCDAB7),
          title: const Text('Do you wish to logout?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close_outlined),
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(orders);
    //print("Date: ${response["Orders"]["date_created"]}, Status: ${response["Orders"]["status"]}");

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        back = await _showMyDialog();
        if (back) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        }
        return back;
      },
      child: Scaffold(
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
                                      _selectedId =
                                          int.parse(orders[_selectedIndex].id);
                                      print(_selectedId);
                                    });
                                  },
                                  onLongPress: () => {
                                    setState(() {
                                      _selectedIndex = index;
                                    }),
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Center(
                                            child: Text("Order information",
                                                style: const TextStyle(
                                                    color: Colors.white))),
                                        content: Text(
                                            "customer email: ${orders[_selectedIndex].customer_email}\n\n"
                                            "computer brand: ${orders[_selectedIndex].brand}\n\n"
                                            "computer model: ${orders[_selectedIndex].model}\n\n"
                                            "computer year: ${orders[_selectedIndex].year_made}\n\n"
                                            "issue: ${orders[_selectedIndex].issue}\n\n",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        backgroundColor: Color(0xFF133B5C),
                                      ),
                                    )
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
                          (orders[_selectedIndex].status == "finished") ||
                                  (orders[_selectedIndex].status == "REPAIRS")
                              ? null
                              : () {
                                  setState(() {
                                    orders[_selectedIndex].status = "finished";
                                  });
                                  updateRepair().getInfo(_selectedId);
                                },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(240, 70),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Finish selected repair",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
