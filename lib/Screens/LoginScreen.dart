import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreenId';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _adhaarNumber, _password, _role;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          leading: Icon(Icons.filter_hdr),
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
                  title: 'Login',
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomRadioButton(
                      buttonColor: Colors.white,
                      autoWidth: true,
                      width: double.infinity,
                      height: 50,
                      enableShape: true,
                      buttonLables: ["Farmer", "Authority", "Ministry"],
                      buttonValues: ["Farmer", "Authority", "Ministry"],
                      radioButtonValue: (value) {
                        _role = value;
                      },
                      selectedColor: Colors.green.shade900,
                      padding: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      CustomTextField(
                        hint: 'Adhaar Number',
                        onSubmitted: (data) {
                          setState(() {
                            _adhaarNumber = data;
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
                          //TODO: Firebase Login
                        },
                        text: 'Login',
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
