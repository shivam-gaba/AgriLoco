import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Models/RegistrationData.dart';
import 'package:agri_loco/Screens/InputBottomSheetScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registrationScreenId';
  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationData>(
      builder: (BuildContext context, RegistrationData registrationData,
          Widget child) {
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
                              registrationData.name = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomTextField(
                            hint: 'Phone Number',
                            onSubmitted: (data) {
                              registrationData.phoneNumber = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomTextField(
                            hint: 'Address',
                            onSubmitted: (data) {
                              registrationData.address = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomTextField(
                            hint: 'Adhaar Number',
                            onSubmitted: (data) {
                              registrationData.adhaarNumber = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomTextField(
                            hint: 'Number of Fields',
                            onSubmitted: (data) {
                              registrationData.numberOfFields = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomTextField(
                            hint: 'Password',
                            onSubmitted: (data) {
                              registrationData.password = data;
                            },
                            inputKhasra: false,
                          ),
                          CustomButton(
                            color: Colors.green.shade900,
                            onPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return InputBottomSheet();
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
      },
    );
  }
}
