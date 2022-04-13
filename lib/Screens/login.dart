import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Users/login_calls.dart';
import 'package:frontend/Screens/customer.dart';
import 'package:frontend/Screens/employee.dart';
import 'package:frontend/Screens/profile.dart';
import 'package:frontend/Screens/register.dart';
import 'package:frontend/Screens/admin.dart';
import 'package:provider/provider.dart';

import '../Backend_calls/Employees/get_repairs.dart';
import '../Backend_calls/Users/auth.dart';

enum Positions{
  admin,
  employee,
  customer
}

List<String> positions = <String>[
  "admin", "employee", "customer"
];

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _position;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    handleUser() async {
      var dio = Dio();
      print(_position);
      Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);

      var response = await Users().getInfo();

      print('->>>> ${response["position"]}');

      if (response["position"] == "admin"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminScreen()));
      }
      else if (response["position"] == "employee"){
        var response2 = await getRepairs().getInfo();
        print("RESPONSE ${response2}");
        response2 ??= [Order("NO", "REPAIRS")];
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeScreen(orders: response2)));
      }
      else if (response["position"] == "customer"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerScreen()));
      }
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF133B5C),
          height: size.height,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    height: size.height * 0.3,
                    color: Color(0xFF1E5F74)
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 20),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Email",
                        fillColor: Colors.white70),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "This field is required.";
                      }else{
                        _position = value;
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Password",
                        fillColor: Colors.white70),
                    obscureText: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "This field is required.";
                      }
                    },
                  ),
                ),

                SizedBox(height: size.height * 0.05),

                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        handleUser();
                      }
                    },
                    child: const Text('SIGN IN'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 60), primary: Color(0xFF1E5F74)),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(text: 'Register here!', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}