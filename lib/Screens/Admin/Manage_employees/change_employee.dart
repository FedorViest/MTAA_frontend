import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/Backend_calls/Admin/manage_employees.dart';
import 'package:frontend/Utils/funcs.dart';

import '../../../Utils/constants.dart';
import '../../Users/profile.dart';
import '../admin.dart';

class ChangeEmployeeScreen extends StatefulWidget {
  final String employeeName;
  final String employeeEmail;

  const ChangeEmployeeScreen(
      {Key? key, required this.employeeName, required this.employeeEmail})
      : super(key: key);

  @override
  State<ChangeEmployeeScreen> createState() => _ChangeEmployeeScreenState();
}

class _ChangeEmployeeScreenState extends State<ChangeEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late String employeeName = widget.employeeName;
  late String employeeEmail = widget.employeeEmail;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwdController = TextEditingController();
  final skillsController = TextEditingController();

  var response_email = "";
  var response_position = "";
  var img;
  var response_img;

  @override
  void initState(){
    super.initState();
    asyncMethod();
  }

  asyncMethod() async{
    img = await getProfilePicture();
    response_img = await getPictureResponse();
    response_email = await getProfileInfo();
    response_position = await getPosition();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print(employeeName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        color: Color(0xFF133B5C),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              response_email.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response_email.toString(), position: response_position.toString(), img: img, response_img: response_img),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Change ${employeeName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Name",
                      fillColor: Colors.white70),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required.";
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Email (optional)",
                        fillColor: Colors.white70),
                    validator: EmailValidator(
                        errorText: "Enter valid email (example@example.com).",
                      ),
               ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextFormField(
                  controller: skillsController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Skills",
                      fillColor: Colors.white70),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required.";
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var response = await changeEmployee().change_employee(
                          employeeEmail, nameController.text, emailController.text,
                          skillsController.text);
                      if (response.runtimeType == DioError) {
                        String errorMessage = Map<String, dynamic>.from(
                                response.response.data)["detail"]
                            .toString();
                        if (errorMessage ==
                            "User with selected email already exists") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Email already in use',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Invalid data',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                          showCorrectDialog(context, 'Employee\'s information has been sucessfuly changed.', 'admin');
                      }
                    }
                  },
                  child: const Text('Change employee'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60),
                      primary: Color(0xFF1E5F74)),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
