import 'package:flutter/material.dart';

import '../../../Backend_calls/Admin/computer_calls.dart';
import '../admin.dart';

class AddComputerScreen extends StatefulWidget {
  @override
  State<AddComputerScreen> createState() => _AddComputerScreenState();
}

class _AddComputerScreenState extends State<AddComputerScreen> {
  final _formKey = GlobalKey<FormState>();

  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E5F74),
      ),
      body: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Color(0xFF133B5C),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    child: const Text(
                      "Add Computer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: TextFormField(
                      controller: brandController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Brand",
                          fillColor: Colors.white70),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: TextFormField(
                      controller: modelController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Model",
                          fillColor: Colors.white70),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: TextFormField(
                      controller: yearController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Year of release",
                          fillColor: Colors.white70),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          addComputer().add_computer(brandController.text, modelController.text, yearController.text);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => AdminScreen()));
                        }
                      },
                      child: const Text('ADD COMPUTER'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60),
                          primary: Color(0xFF1E5F74)),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}