import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Screens/rate_technician.dart';


import 'customer.dart';
import 'profile.dart';


class Order{
  String date;
  String technician;
  String status;

  Order({required this.date, required this.technician, required this.status});
}


class MyOrdersScreen extends StatelessWidget {

  final List colors = [Color(0xFF1E5F74), Color(0xFF133B5C)];

  final List orders = [
    Order(date: "2020-02-28", technician: "Robert", status: "Finished"),
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

  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RateTechnicianScreen()));
                      },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 60), primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Rate technician",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white
                        ),
                      ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF133B5C)
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
                              title: Text(
                                orders[index].technician,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}