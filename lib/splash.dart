import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Users/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          alignment: Alignment.topCenter,
          child: Image.asset('assets/splashscreen/logo.png'),
        ),
      ),
    );
  }
}