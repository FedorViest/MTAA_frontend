import 'package:flutter/material.dart';
import 'package:frontend/Utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.topCenter,
        color: Color(0xFF1D2D50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
          //SizedBox(height: size.height * 0.02),
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage("assets/images/unknown.png"),
              ),
              Text(
                "admin Admin",
                style: TextStyle(
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              IconButton(
                  highlightColor: COLOR_CREAM,
                  iconSize: 50,
                  onPressed: () {},
                  icon: Icon(
                      Icons.settings_applications),
              ),
            ],
          ),
    ),
        ],
        ),
      );
  }
}