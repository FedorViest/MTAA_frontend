import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/Utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
  final String email;

  const Profile({Key? key, required this.email}) : super(key: key);
}

class _ProfileState extends State<Profile> {
  late String email = widget.email;
  final _formKey = GlobalKey<FormState>();

  late var _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.topCenter,
      color: Color(0xFF1D2D50),
      child: Form(
        key: _formKey,
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
                  GestureDetector(
                    onTap: () async {
                      // mark the function as async
                      print('tap');
                      // Show PopUp

                      // await the dialog
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const CircleAvatar(
                                    radius: 100,
                                    backgroundImage: ExactAssetImage(
                                        'assets/images/unknown.png'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(240, 70),
                                        primary: Color(0xFF1E5F74)),
                                    child: const Text(
                                      "Upload new photo",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          ExactAssetImage('assets/images/unknown.png'),
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        fontSize: size.width / 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  IconButton(
                    highlightColor: COLOR_CREAM,
                    iconSize: 50,
                    onPressed: () async {
                      _ipController.text = set_ip;
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "WebRTC server IP",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: _ipController,
                                    validator: (value) {
                                      if (value == null || value.length < 10) {
                                        return "Kokot";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        hintText: "IP",
                                        fillColor: Colors.white70),
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  ElevatedButton(
                                    onPressed: () {
                                      _ipController.text = set_ip;
                                      if (_formKey.currentState!.validate()) {
                                        set_ip = _ipController.text;
                                        print(set_ip);
                                        //Navigator.pop(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(240, 70),
                                        primary: Color(0xFF1E5F74)),
                                    child: const Text(
                                      "Set server IP",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.settings_applications),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
