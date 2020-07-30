import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
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

      await fieldsData.document(khasraNumber).setData({
        'ownerId': loginData.adhaarNumber,
        'isVerified': false,
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
                inputType: TextInputType.number,
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
                inputType: TextInputType.number,
                onSubmitted: (value) {
                  setState(() {
                    fieldSize = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomRadioButton(
                  buttonColor: Colors.white,
                  autoWidth: true,
                  height: 40,
                  enableShape: true,
                  buttonLables: ["Canal", "Ground"],
                  buttonValues: ["Canal", "Ground"],
                  radioButtonValue: (value) {
                    setState(() {
                      waterSource = value;
                    });
                  },
                  selectedColor: Colors.green.shade900,
                  padding: 0,
                ),
              ),
              CustomButton(
                  color: Colors.green.shade900,
                  text: 'Submit',
                  onPress: () {
                    //TODO: Firebase send data
                    if (khasraNumber != null &&
                        fieldSize != null &&
                        cropType != null) {
                      if (waterSource == null) {
                        waterSource = 'Canal';
                      }
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
