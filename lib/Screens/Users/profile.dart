import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/Backend_calls/Users/profile_pictures.dart';
import 'package:frontend/Utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
  final String email;
  final img;
  final response_img;

  const Profile({Key? key, required this.email, required this.img, required this.response_img}) : super(key: key);
}

class _ProfileState extends State<Profile> {
  late String email = widget.email;
  late var img = widget.img;
  late var response_img = widget.response_img;
  final _formKey = GlobalKey<FormState>();

  getImage(type) async {
    File _image;
    final picker = ImagePicker();
    var _pickedFile;
    if (type == "gallery") {
      _pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 500, // <- reduce the image size
          maxWidth: 500);
    } else if (type == "camera") {
      _pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 1000, // <- reduce the image size
          maxWidth: 1000);
    }

    if (_pickedFile != null) {
      _image = File(_pickedFile.path);
      await UploadPicture().uploadImage(_image);
    }
  }

  late var _ipController = TextEditingController();

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
                GestureDetector(
                  onTap: () async {
                    print(response_img);
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundImage: img,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await getImage("gallery");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(240, 70),
                                      primary: Color(0xFF1E5F74)),
                                  child: const Text(
                                    "Upload new photo from gallery",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                ElevatedButton(
                                  onPressed: () async {
                                    await getImage("camera");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(240, 70),
                                      primary: Color(0xFF1E5F74)),
                                  child: const Text(
                                    "Upload new photo from camera",
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
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: response_img == null ? const ExactAssetImage('assets/images/unknown.png'): img,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Form(
                  key: _formKey,
                  child: IconButton(
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
                                      if(_ipController.text.isEmpty) {
                                        _ipController.text = set_ip;
                                      }

                                      if (_formKey.currentState!.validate()) {
                                        if (ipExp.hasMatch(_ipController.text) == false) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'This IPv4 address is not valid.',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                        else {
                                          set_ip = _ipController.text;
                                        }
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
