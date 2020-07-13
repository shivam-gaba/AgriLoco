import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/RegistrationData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputBottomSheet extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<RegistrationData>(
      builder: (BuildContext context, RegistrationData registrationData,
          Widget child) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Enter Khasra Numbers',
                    style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: (registrationData.numberOfFields) != null
                            ? int.parse(registrationData.numberOfFields)
                            : 0,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomTextField(
                            inputKhasra: true,
                            hint: 'Enter Khasra Number',
                            onSubmitted: (value) {
                              registrationData
                                  .addKhasraNumber(int.parse(value));
                            },
                          );
                        }),
                  ),
                  CustomButton(
                    color: Colors.green.shade900,
                    onPress: () {
                      //TODO: Firebase Login
                    },
                    text: 'Submit',
                  ),
                ],
              ),
            ));
      },
    );
  }
}
