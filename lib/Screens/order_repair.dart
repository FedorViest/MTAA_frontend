import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


import 'customer.dart';
import 'profile.dart';

class OrderRepairScreen extends StatefulWidget {
  @override
  _OrderRepairScreenState createState() => _OrderRepairScreenState();
}

class _OrderRepairScreenState extends State<OrderRepairScreen>{
  String? _dropDownValue;

  List<String> items = [
    "Mac",
    "HP",
    "Asus",
    "Lenovo",
    "Other",
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Profile(),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Videocall",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                SizedBox(width: size.width * 0.2),
                DropdownButton2(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items){
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  hint: const Text(
                    "Choose device",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  value: _dropDownValue,
                  onChanged: (value){
                    setState((){
                      _dropDownValue = value as String;
                    }
                    );
                  },
                ),
                SizedBox(height: size.height * 0.1),
                TextField(
                  maxLength: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Describe problem",
                      fillColor: Colors.white70),
                ),
                SizedBox(height: size.height * 0.15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerScreen()));
                  },
                  child: const Text(
                    "Submit request",
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