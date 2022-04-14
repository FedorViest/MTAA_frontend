import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'customer.dart';
import 'profile.dart';

class RateTechnicianScreen extends StatefulWidget {
  @override
  _RateTechnicianScreenState createState() => _RateTechnicianScreenState();
}

class Employee {
  String email;

  Employee(this.email);
}

class _RateTechnicianScreenState extends State<RateTechnicianScreen> {
  String? _dropDownValue;
  double _currentValue = 0;

  List<String> emails = [
    "employee@gmail.com",
    "employee1@gmail.com",
    "employee2@gmail.com",
    "employee3@gmail.com",
    "employee4@gmail.com",
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo[200],
          height: size.height,
          child: Column(
            children: [
              Profile(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: DropdownButton2(
                        alignment: Alignment.center,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Colors.black,
                        items: emails.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        hint: const Text(
                          "Select technician",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        value: _dropDownValue,
                        onChanged: (value) {
                          setState(() {
                            _dropDownValue = value as String;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Rating: $_currentValue',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Slider(
                        value: _currentValue,
                        min: 0.0,
                        max: 5.0,
                        divisions: 20,
                        activeColor: Color(0XFF1D2D50),
                        thumbColor: Color(0XFF1D2D50),
                        inactiveColor: Color(0XFFFCDAB7),
                        label: _currentValue.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentValue = value;
                          });
                        }),
                  ),
                  SizedBox(height: size.height * 0.1),
                  TextField(
                    maxLength: 50,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Write Rating",
                        filled: true,
                        fillColor: Colors.white70),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerScreen()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: const Text(
                      "Rate Technician",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
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
