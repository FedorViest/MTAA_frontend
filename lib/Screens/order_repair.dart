import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'customer.dart';
import 'profile.dart';

class OrderRepairScreen extends StatefulWidget {
  @override
  _OrderRepairScreenState createState() => _OrderRepairScreenState();
}

class _OrderRepairScreenState extends State<OrderRepairScreen> {
  String? _dropDownValue;

  List<String> items = [
    "Mac",
    "HP",
    "Asus",
    "Lenovo",
    "Other",
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(right: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 50), primary: Color(0xFF1E5F74)),
                  icon: Icon(
                    Icons.videocam,
                    color: Colors.black,
                    size: 50,
                  ),
                  label: Text(
                    "Video call",
                  ),
                  onPressed: () {},
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Container(
                    width: size.width * 0.9,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCDAB7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: DropdownButton2(
                        alignment: Alignment.center,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Colors.black,
                        items: items.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        hint: const Text(
                          "Choose a brand",
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
                  SizedBox(height: size.height * 0.05),
                  Container(
                    width: size.width * 0.9,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCDAB7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: DropdownButton2(
                        alignment: Alignment.center,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Colors.black,
                        items: items.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        hint: const Text(
                          "Choose your device",
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
                  SizedBox(height: size.height * 0.05),
                  Container(
                    width: size.width * 0.9,
                    child: TextField(
                      minLines: 6,
                      // any number you need (It works as the rows for the textarea)
                      maxLength: 50,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Describe your problem here.",
                          filled: true,
                          fillColor: Color(0xFFFCDAB7)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 60),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Submit request",
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
      ),
    );
  }
}
