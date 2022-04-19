import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/Backend_calls/Customers/add_order.dart';
import 'package:frontend/Backend_calls/Customers/get_computers.dart';
import 'package:frontend/Utils/funcs.dart';
import 'package:frontend/webRTC/call_sample/call_sample.dart';
import 'package:http/http.dart';

import '../../../Backend_calls/Users/profile_pictures.dart';
import '../../../Utils/constants.dart';
import '../customer.dart';
import '../../Users/profile.dart';

class OrderRepairScreen extends StatefulWidget {
  final List<Computers> computers;

  @override
  _OrderRepairScreenState createState() => _OrderRepairScreenState();

  const OrderRepairScreen({Key? key, required this.computers})
      : super(key: key);
}

class _OrderRepairScreenState extends State<OrderRepairScreen> {
  int _selectedIndex = 0;
  late String _selectedBrand;
  late String _selectedModel;
  late String _selectedYear;
  final _issueController = TextEditingController();

  late List<Computers> computers = widget.computers;

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

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF133B5C),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              response_email.toString()=="" ? const CircularProgressIndicator():
              Profile(email: response_email.toString(), position: response_position.toString(), img: img, response_img: response_img),
              SizedBox(height: size.height * 0.02),
              SizedBox(height: size.height * 0.01),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF133B5C),
                ),
                child: SizedBox(
                  height: size.height * 0.3,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: computers.length,
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
                                _selectedBrand =
                                    computers[_selectedIndex].brand.toString();
                                _selectedModel =
                                    computers[_selectedIndex].model.toString();
                                _selectedYear = computers[_selectedIndex]
                                    .year_made
                                    .toString();
                                print(_selectedYear);
                                print(_selectedBrand);
                                print(_selectedModel);
                              });
                            },
                            horizontalTitleGap: 30,
                            title: Text(
                              computers[index].model,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            leading: Text(
                              computers[index].brand,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              computers[index].year_made,
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
              SizedBox(height: size.height * 0.05),
              Container(
                width: size.width * 0.9,
                child: TextField(
                  controller: _issueController,
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Describe your problem here.",
                      filled: true,
                      fillColor: Color(0xFFFCDAB7)),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 60),
                            primary: Color(0xFF1E5F74)),
                        icon: const Icon(
                          Icons.videocam,
                          color: Colors.black,
                          size: 50,
                        ),
                        label: const Text(
                          "Video call",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if(ip_const == null){
                            ip_const = await set_ip;
                          }
                          print(ip_const);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CallSample(host: ip_const,)));
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_selectedIndex == 0){
                            _selectedBrand =
                                computers[_selectedIndex].brand.toString();
                            _selectedModel =
                                computers[_selectedIndex].model.toString();
                            _selectedYear = computers[_selectedIndex]
                                .year_made
                                .toString();
                          }
                          var response = await AddOrder().add_order(
                              _selectedBrand,
                              _selectedModel,
                              _selectedYear,
                              _issueController.text);
                          print("RESPONSE");
                          print(response.data["status"]);
                          if (response.data["status"] == "accepted") {
                            showCorrectDialog(context, 'Order has been sucessfuly submitted.', 'customer');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 60),
                            primary: Color(0xFF1E5F74)),
                        child: const Text(
                          "Submit request",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
