import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Customers/rate_employee.dart';
import 'package:frontend/Utils/funcs.dart';

import '../../../Backend_calls/Users/profile_pictures.dart';
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
  var img;
  var response_img;

  @override
  void initState(){
    super.initState();
    asyncMethod();
  }

  asyncMethod() async{
    response = await getProfileInfo();
    img = await getProfilePicture();
    response_img = await getPictureResponse();
    setState(() {});
  }

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
              response.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response.toString(), img: img, response_img: response_img),
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
                        textAlign: TextAlign.center,
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
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                        border: Border.all(
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:Column(
                    children: [
                   Text(
                    'Rating: $_currentValue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    Slider(
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
                          }
                          );
                        }
                        ),
                    ],
                  ),
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
                        showCorrectDialog(context, 'Your rating has been sucessfuly submitted.', 'customer');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 60),
                        primary: Color(0xFF1E5F74)),
                    child: const Text(
                      "Rate technician",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
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
