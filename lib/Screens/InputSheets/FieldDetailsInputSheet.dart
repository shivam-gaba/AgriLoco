import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:agri_loco/Screens/AuthScreens/WelcomeScreen.dart';
import 'package:agri_loco/Screens/Dashboards/FarmerDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class FieldDetailsInputSheet extends StatefulWidget {
  @override
  _FieldDetailsInputSheetState createState() => _FieldDetailsInputSheetState();
}

bool _isSpinnerShowing = false;

class _FieldDetailsInputSheetState extends State<FieldDetailsInputSheet> {
  String khasraNumber, cropType, fieldSize, waterSource;

  Future<void> sendFieldData(LoginData loginData, BuildContext context) async {
    setState(() {
      _isSpinnerShowing = true;
    });

    try {
      var _firestore = Firestore.instance;
      var fieldsData = _firestore.collection('FieldsData');

      await fieldsData
          .document(loginData.adhaarNumber)
          .collection('FarmerFieldData')
          .document(khasraNumber)
          .setData({
        'cropType': cropType,
        'fieldSize': fieldSize,
        'waterSource': waterSource,
      }).whenComplete(() {
        setState(() {
          _isSpinnerShowing = false;
        });
      }).then((value) {
        return Navigator.pop(context);
      }).catchError((onError) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          confirmBtnColor: Colors.green.shade900,
          title: 'Upload Failed !! ',
        );
      });
    } catch (e) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        confirmBtnColor: Colors.green.shade900,
        title: 'Upload Failed !!',
        text: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginData>(
        builder: (BuildContext context, LoginData loginData, Widget child) {
      return ModalProgressHUD(
        inAsyncCall: _isSpinnerShowing,
        child: Container(
          color: Colors.greenAccent,
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              CustomTextField(
                hint: 'Khasra Number',
                onSubmitted: (value) {
                  setState(() {
                    khasraNumber = value;
                  });
                },
              ),
              CustomTextField(
                hint: 'Crop type',
                onSubmitted: (value) {
                  setState(() {
                    cropType = value;
                  });
                },
              ),
              CustomTextField(
                hint: 'Field Size',
                onSubmitted: (value) {
                  setState(() {
                    fieldSize = value;
                  });
                },
              ),
              CustomTextField(
                hint: 'Water Source',
                onSubmitted: (value) {
                  setState(() {
                    waterSource = value;
                  });
                },
              ),
              CustomButton(
                  color: Colors.green.shade900,
                  text: 'Submit',
                  onPress: () {
                    //TODO: Firebase send data
                    if (khasraNumber != null &&
                        fieldSize != null &&
                        waterSource != null &&
                        cropType != null) {
                      sendFieldData(loginData, context);
                    } else {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          title: 'Please enter all fields !!',
                          confirmBtnColor: Colors.green.shade900);
                    }
                  })
            ],
          ),
        ),
      );
    });
  }
}
