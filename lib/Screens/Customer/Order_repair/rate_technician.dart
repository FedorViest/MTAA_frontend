import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Customers/rate_employee.dart';

import '../../../Utils/constants.dart';
import '../customer.dart';
import '../../Users/profile.dart';

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

  Future<bool> _showMyDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCDAB7),
          title: const Text('Thank you for your rating'),
          alignment: Alignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CustomerScreen()));
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

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
              response.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response.toString()),
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
                      if (response.statusCode == 200){
                        _showMyDialog();
                      }
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
