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
        color: Colors.indigo[200],
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
                    fixedSize: Size(150, 50),
                      primary: Color(0xFF1E5F74)
                  ),
                    icon: Icon(
                      Icons.videocam,
                      color: Colors.black,
                      size: 50,
                    ),
                    label: Text(
                      "Video call",
                    ), onPressed: () {},
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
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
                ),
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
                      hintText: "Describe problem",
                      filled: true,
                      fillColor: Colors.white70),
                ),
                SizedBox(height: size.height * 0.15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
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