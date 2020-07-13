import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Components/InputBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreenId';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _name,
      _address,
      _phoneNumber,
      _adhaarNumber,
      _password,
      _numberOfFields;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          leading: Icon(
            Icons.filter_hdr,
          ),
          backgroundColor: Colors.green.shade900,
          title: Text('AGRI LOCO',
              style: GoogleFonts.indieFlower(
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTitle(
                  title: 'Register',
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      CustomTextField(
                        hint: 'Name',
                        onSubmitted: (data) {
                          setState(() {
                            _name = data;
                          });
                        },
                      ),
                      CustomTextField(
                        hint: 'Phone Number',
                        onSubmitted: (data) {
                          setState(() {
                            _phoneNumber = data;
                          });
                        },
                      ),
                      CustomTextField(
                        hint: 'Address',
                        onSubmitted: (data) {
                          setState(() {
                            _address = data;
                          });
                        },
                      ),
                      CustomTextField(
                        hint: 'Adhaar Number',
                        onSubmitted: (data) {
                          setState(() {
                            _adhaarNumber = data;
                          });
                        },
                      ),
                      CustomTextField(
                        hint: 'Number of Fields',
                        onSubmitted: (data) {
                          setState(() {
                            _numberOfFields = data;
                          });
                        },
                      ),
                      CustomTextField(
                        hint: 'Password',
                        onSubmitted: (data) {
                          setState(() {
                            _password = data;
                          });
                        },
                      ),
                      CustomButton(
                        color: Colors.green.shade900,
                        onPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return InputBottomSheet(
                                    numberOfFields: _numberOfFields,
                                    address: _address,
                                    adhaarNumber: _adhaarNumber,
                                    name: _name,
                                    password: _password,
                                    phoneNumber: _phoneNumber);
                              });
                        },
                        text: 'Proceed',
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
