import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Models/FarmerAuthData.dart';
import 'package:agri_loco/Screens/InputBottomSheetScreen.dart';
import 'package:cool_alert/cool_alert.dart';
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
                          ),
                          CustomTextField(
                            hint: 'Phone Number',
                            onSubmitted: (data) {
                              registrationData.phoneNumber = data;
                            },
                          ),
                          CustomTextField(
                            hint: 'Address',
                            onSubmitted: (data) {
                              registrationData.address = data;
                            },
                          ),
                          CustomTextField(
                            hint: 'Adhaar Number',
                            onSubmitted: (data) {
                              registrationData.adhaarNumber = data;
                            },
                          ),
                          CustomTextField(
                            hint: 'Number of Fields',
                            onSubmitted: (data) {
                              registrationData.numberOfFields = data;
                            },
                          ),
                          CustomTextField(
                            hint: 'Password',
                            onSubmitted: (data) {
                              registrationData.password = data;
                            },
                          ),
                          CustomButton(
                            color: Colors.green.shade900,
                            onPress: () {
                              if (registrationData.name == null ||
                                  registrationData.phoneNumber == null ||
                                  registrationData.adhaarNumber == null ||
                                  registrationData.password == null ||
                                  registrationData.address == null ||
                                  registrationData.numberOfFields == null) {
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.info,
                                    title: 'Please enter all fields !!',
                                    confirmBtnColor: Colors.green.shade900);
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return InputBottomSheet();
                                    });
                              }
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
