import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Customers/get_computers.dart';
import 'package:frontend/Backend_calls/Customers/get_orders.dart';
import 'package:frontend/Backend_calls/Customers/my_ratings.dart';
import 'package:frontend/Screens/Customer/My_orders/my_orders.dart';
import 'package:frontend/Screens/Customer/My_ratings/my_ratings.dart';
import 'package:frontend/Screens/Customer/Order_repair/order_repair.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Backend_calls/Users/profile_pictures.dart';
import '../../Utils/constants.dart';
import '../Users/login.dart';
import '../Users/profile.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late bool back;

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

  Future<bool> _showMyDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCDAB7),
          title: const Text('Do you wish to logout?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close_outlined),
                  iconSize: 50,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: () async {
                    Navigator.pop(context, true);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    setState(() {});

    return WillPopScope(
      onWillPop: () async {
        back = await _showMyDialog();
        if (back) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        }
        return back;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E5F74),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Color(0xFF133B5C),
            child: Column(
              children: [
                response_email.toString()=="" ? const CircularProgressIndicator():
                Profile(email: response_email.toString(), position: response_position.toString(), img: img, response_img: response_img),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    ElevatedButton(
                      onPressed: () async {
                        var response = await getComputersCustomer().getInfo();
                        print(response);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderRepairScreen(computers: response)));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Create order",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      onPressed: () async {
                        var response = await getRatings().getInfo();
                        print("RESPONSE" + response.toString());
                        response ??= [Rating(0, "RATINGS","NO",0, "NO")];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyRatingsScreen(ratings: response)));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "My ratings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      onPressed: () async {
                        var response = await getOrders().getOrdersFunc();
                        print("RESPONSE" + response.toString());
                        response ??= [Order(0, "ORDERS", "NO")];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyOrdersScreen(orders: response)));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "My orders",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
