import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Screens/register.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Color(0xFF133B5C),
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
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Email",
                    fillColor: Colors.white70),
              ),
            ),


            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Password",
                    fillColor: Colors.white70),
                obscureText: true,
              ),
            ),

            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
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
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(text: 'Register here!', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
              )
            ),
          ],
        ),
      )
    );
  }
}