import 'package:flutter/material.dart';
import 'package:frontend/Backend_calls/Customers/my_ratings.dart';
import 'package:frontend/Backend_calls/Employees/update_repair.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Backend_calls/Users/profile_pictures.dart';
import '../../../Utils/funcs.dart';

import '../../../Utils/constants.dart';
import '../../Users/profile.dart';
import '../../../Backend_calls/Employees/get_repairs.dart';
import '../customer.dart';

class MyRatingsScreen extends StatefulWidget {
  final List<Rating> ratings;

  const MyRatingsScreen({Key? key, required this.ratings}) : super(key: key);

  @override
  _MyRatingsScreenState createState() => _MyRatingsScreenState();
}

class _MyRatingsScreenState extends State<MyRatingsScreen> {
  int _selectedIndex = 0;
  int _selectedId = 0;
  late List<Rating> ratings = widget.ratings;

  var response = "";
  var img;
  var response_img;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  asyncMethod() async {
    response = await getProfileInfo();
    img = await getProfilePicture();
    response_img = await getPictureResponse();
    setState(() {});
  }

    @override
    Widget build(BuildContext context) {
      //print("Date: ${response["Orders"]["date_created"]}, Status: ${response["Orders"]["status"]}");

      Size size = MediaQuery
          .of(context)
          .size;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E5F74),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Color(0xFF133B5C),
            child: Column(
              children: [
                response.toString() == "" ? const CircularProgressIndicator() :
                Profile(email: response.toString(), img: img, response_img: response_img),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF133B5C),
                      ),
                      child: SizedBox(
                        height: size.height * 0.5,
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: ratings.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: index % 2 == 0
                                  ? Color(0xFF1E5F74)
                                  : Color(0xFFFCDAB7),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  selected: index == _selectedIndex,
                                  selectedTileColor: Color(0xffc8a2c8),
                                  selectedColor: Color(0xFFFCDAB7),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                      _selectedId = ratings[_selectedIndex].id;
                                      print(_selectedId);
                                    });
                                  },
                                  onLongPress: () =>
                                  {
                                    setState(() {
                                      _selectedIndex = index;
                                    }),
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog(
                                            title: Center(
                                                child: Text("Rating information",
                                                    style: const TextStyle(
                                                        color: Colors.white))),
                                            content: Text(
                                                "Employee: ${ratings[_selectedIndex].employee_email}\n\n"
                                                    "Rating: ${ratings[_selectedIndex].rating}\n\n"
                                                    "Comment: ${ratings[_selectedIndex].comment}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            backgroundColor: Color(0xFF133B5C),
                                          ),
                                    )
                                  },
                                  horizontalTitleGap: 30,
                                  leading: Text(
                                    ratings[index].employee_email,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: Text(
                                    ratings[index].rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    ElevatedButton(
                      onPressed: () async {
                        var response = await deleteRating().delete_rating(
                            _selectedId);
                        if (response.statusCode == 200) {
                          showCorrectDialog(context, 'Rating has been sucessfuly deleted.', 'customer');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(240, 70),
                          primary: Color(0xFF1E5F74)),
                      child: const Text(
                        "Delete selected rating",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
