import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Screens/rate_technician.dart';
import '../Backend_calls/Admin/get_ratings.dart';

import 'customer.dart';
import 'profile.dart';

class EmployeeRatingScreen extends StatefulWidget {
  final List<Rating> ratings;
  const EmployeeRatingScreen({Key? key, required this.ratings}) : super(key: key);

  @override
  _EmployeeRatingScreenState createState() => _EmployeeRatingScreenState();
}

class _EmployeeRatingScreenState extends State<EmployeeRatingScreen> {

  late List<Rating> ratings = widget.ratings;

  Widget build(BuildContext context) {

    print(ratings);

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
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF133B5C),
                    ),
                    child:SizedBox(
                      height: size.height * 0.7,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: ratings.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            color: index % 2 == 0 ? Color(0xFF1E5F74):Color(0xFFFCDAB7),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ListTile(
                                horizontalTitleGap: 30,
                                leading: Text(ratings[index].employee_email,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Text(ratings[index].rating.toString(),
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