import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/FarmerRegData.dart';
import 'package:agri_loco/Screens/AuthScreens/RegistrationScreen.dart';
import 'package:agri_loco/Screens/AuthScreens/WelcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class KhasraNumberInputSheet extends StatefulWidget {
  @override
  _KhasraNumberInputSheetState createState() => _KhasraNumberInputSheetState();
}

class _KhasraNumberInputSheetState extends State<KhasraNumberInputSheet> {
  bool _spinnerShowing = false;

  Future<void> uploadFarmerInfo(
      FarmerRegData registrationData, BuildContext context) async {
    setState(() {
      _spinnerShowing = true;
    });

    try {
      var _firestore = Firestore.instance;

      var _farmerAuthReg = _firestore.collection('FarmerAuth');
      await _farmerAuthReg.document(registrationData.adhaarNumber).setData({
        'name': registrationData.name,
        'phoneNumber': registrationData.phoneNumber,
        'adhaarNumber': registrationData.adhaarNumber,
        'password': registrationData.password,
        'city': registrationData.city,
        'state': registrationData.state,
        'district': registrationData.district,
        'village': registrationData.village,
        'numberOfFields': registrationData.numberOfFields,
        'khasraNumberList':
            registrationData.getKhasraNumberList.values.toList(),
        'isVerified': false
      }).whenComplete(() {
        setState(() {
          _spinnerShowing = false;
        });
      }).then((value) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnColor: Colors.green.shade900,
            title: 'Registration Successful !!',
            onConfirmBtnTap: () => Navigator.popUntil(
                context, ModalRoute.withName(WelcomeScreen.id)));
        return;
      }).catchError((onError) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            confirmBtnColor: Colors.green.shade900,
            title: 'Registration Failed !! ',
            onConfirmBtnTap: () => Navigator.popUntil(
                context, ModalRoute.withName(RegistrationScreen.id)));
        return;
      });
    } catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          confirmBtnColor: Colors.green.shade900,
          title: 'Registration Failed !!',
          text: e.toString(),
          onConfirmBtnTap: () => Navigator.popUntil(
              context, ModalRoute.withName(RegistrationScreen.id)));
      return;
    }
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.green.shade900,
      inAsyncCall: _spinnerShowing,
      child: Consumer<FarmerRegData>(
        builder: (BuildContext context, FarmerRegData registrationData,
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
                              hint: 'Enter Khasra Number',
                              onSubmitted: (value) {
                                registrationData.addKhasraNumber(
                                    int.parse(value), index);
                              },
                            );
                          }),
                    ),
                    CustomButton(
                      color: Colors.green.shade900,
                      onPress: () {
                        if (registrationData.getKhasraNumberList.length <
                            int.parse(registrationData.numberOfFields)) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              title: 'Please enter all fields !!',
                              confirmBtnColor: Colors.green.shade900);
                        } else {
                          uploadFarmerInfo(registrationData, context);
                        }
                      },
                      text: 'Submit',
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
