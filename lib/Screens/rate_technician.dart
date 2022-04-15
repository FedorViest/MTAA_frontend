import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Customers/rate_employee.dart';

import 'customer.dart';
import 'profile.dart';

class Employee {
  String email;

  Employee(this.email);
}

class RateTechnicianScreen extends StatefulWidget {
  final String email;
  @override
  _RateTechnicianScreenState createState() => _RateTechnicianScreenState();

  const RateTechnicianScreen({Key? key, required this.email}) : super(key: key);
}

class _RateTechnicianScreenState extends State<RateTechnicianScreen> {
  String? _dropDownValue;
  double _currentValue = 2.5;
  final _commentController = TextEditingController();

  late String email = widget.email;

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
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width,
                      child: Text(
                        "Technician: $email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                    controller: _commentController,
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
                    onPressed: () async {
                      var response = await AddRating().add_rating(email, _currentValue, _commentController.text);
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
