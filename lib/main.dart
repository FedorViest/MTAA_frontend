import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Users/auth.dart';
import 'package:provider/provider.dart';

import 'Screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>Auth(),
      child:MaterialApp(
        title: 'Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}