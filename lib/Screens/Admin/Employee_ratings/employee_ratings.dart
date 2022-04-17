import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Backend_calls/Admin/get_ratings.dart';

import '../../../Backend_calls/Users/profile_pictures.dart';
import '../../../Utils/constants.dart';
import '../../Customer/customer.dart';
import '../../Users/profile.dart';

class EmployeeRatingScreen extends StatefulWidget {
  final List<Rating> ratings;

  const EmployeeRatingScreen({Key? key, required this.ratings})
      : super(key: key);

  @override
  _EmployeeRatingScreenState createState() => _EmployeeRatingScreenState();
}

class _EmployeeRatingScreenState extends State<EmployeeRatingScreen> {
  late List<Rating> ratings = widget.ratings;
  int _selectedIndex = 0;

  var response = "";
  var img;
  var response_img;

  @override
  void initState(){
    super.initState();
    asyncMethod();
  }

  asyncMethod() async{
    response = await getProfileInfo();
    img = await getProfilePicture();
    response_img = await getPictureResponse();
    setState(() {});
  }

  Widget build(BuildContext context) {
    print(ratings);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF133B5C),
          height: size.height,
          child: Column(
            children: [
              response.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response.toString(), img: img, response_img: response_img),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF133B5C),
                    ),
                    child: SizedBox(
                      height: size.height * 0.7,
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
                                horizontalTitleGap: 30,
                                selected: index == _selectedIndex,
                                selectedTileColor: Color(0xffc8a2c8),
                                selectedColor: Color(0xFFFCDAB7),
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                onLongPress: () async {
                                  _selectedIndex = index;
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Center(
                                          child: Text(
                                            "Rating info",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        content: Text(
                                            "Employee: ${ratings[index].employee_name}\n\n"
                                                "Email: ${ratings[index].employee_email}\n\n"
                                                "Customer: ${ratings[index].customer_name}\n\n"
                                                "Email: ${ratings[index].customer_email}\n\n"
                                                "Rating: ${ratings[index].rating}\n\n"
                                                "Comment: ${ratings[index].comment}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        backgroundColor: Color(0xFF133B5C),
                                      ),
                                    );
                                  },
                                title: Text(
                                  ratings[index].employee_name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
