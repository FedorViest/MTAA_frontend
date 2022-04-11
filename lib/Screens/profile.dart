import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.topCenter,
        child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("assets/images/unknown.png"),
              ),
              Text(
                "admin Admin",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "customer@gmail.com",
                style: TextStyle(
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
        ),
      );
  }
}