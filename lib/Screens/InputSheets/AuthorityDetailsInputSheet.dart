import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AuthorityDetailsInputSheet extends StatefulWidget {
  @override
  _AuthorityDetailsInputSheetState createState() =>
      _AuthorityDetailsInputSheetState();
}

bool _isSpinnerShowing = false;
var _firestore = Firestore.instance;
String name, phoneNumber, password, adhaarNumber;

class _AuthorityDetailsInputSheetState
    extends State<AuthorityDetailsInputSheet> {
  Future<void> sendAuthorityData() async {
    setState(() {
      _isSpinnerShowing = true;
    });

    try {
      await _firestore
          .collection('AuthorityAuth')
          .document(adhaarNumber)
          .setData({
        'name': name,
        'password': password,
        'adhaarNumber': adhaarNumber,
        'phoneNumber': phoneNumber
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
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Container(
        color: Colors.greenAccent,
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            CustomTextField(
              hint: 'Name',
              onSubmitted: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            CustomTextField(
              hint: 'Adhaar Number',
              onSubmitted: (value) {
                setState(() {
                  adhaarNumber = value;
                });
              },
            ),
            CustomTextField(
              hint: 'Phone Number',
              onSubmitted: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            CustomTextField(
              hint: 'Password',
              onSubmitted: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            CustomButton(
                color: Colors.green.shade900,
                text: 'Submit',
                onPress: () {
                  //TODO: Firebase send data
                  if (name != null &&
                      password != null &&
                      adhaarNumber != null &&
                      phoneNumber != null) {
                    sendAuthorityData();
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
  }
}
