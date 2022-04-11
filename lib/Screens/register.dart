import 'package:flutter/material.dart';
import 'package:frontend/Screens/login.dart';

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: const Text(
                  "Register",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "full name",
                    filled: true,
                    fillColor: Colors.white60,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "email",
                    filled: true,
                    fillColor: Colors.white60,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "password",
                    filled: true,
                    fillColor: Colors.white60,
                  ),
                  obscureText: true,
                ),
              ),

              SizedBox(height: size.height * 0.05),

              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  color: Colors.white60,
                  textColor: Colors.white,
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}