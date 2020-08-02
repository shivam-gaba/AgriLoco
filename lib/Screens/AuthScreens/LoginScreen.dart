import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:agri_loco/Screens/Dashboards/Authority/AuthorityDashboard.dart';
import 'package:agri_loco/Screens/Dashboards/Farmer/FarmerDashboard.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/MinistryDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:provider/provider.dart';

bool _isSpinnerShowing = false;

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreenId';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void setFarmerData(LoginData loginData, DocumentSnapshot _farmerData) {
    loginData.village = _farmerData.data["village"];
    loginData.city = _farmerData.data["city"];
    loginData.state = _farmerData.data["state"];
    loginData.district = _farmerData.data["district"];
    loginData.numberOfFields = _farmerData.data["numberOfFields"];
    loginData.phoneNumber = _farmerData.data["phoneNumber"];
    loginData.name = _farmerData.data["name"];
    loginData.adhaarNumber = _farmerData.data["adhaarNumber"];
    loginData.password = _farmerData.data["password"];

    int index = 0;
    for (var khasraNumber in _farmerData.data["khasraNumberList"]) {
      loginData.addKhasraNumber(khasraNumber, index);
      index++;
    }
  }

  Future<void> loginUser(LoginData loginData, BuildContext context) async {
    var _firestore = Firestore.instance;

    if (loginData.role == 'Farmer') {
      var _farmerData = await _firestore
          .collection("FarmerAuth")
          .document(loginData.adhaarNumber)
          .get();

      if (_farmerData.data != null) {
        if (_farmerData.data["password"] == loginData.password) {
          if (_farmerData.data['isVerified'] == true) {
            setFarmerData(loginData, _farmerData);

            Navigator.pushNamed(context, FarmerDashboard.id);
          } else {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                title: '',
                text: 'User Has Not Been Verified Yet !!',
                confirmBtnColor: Colors.green.shade900);
          }
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.warning,
              title: 'Wrong Password !!',
              confirmBtnColor: Colors.green.shade900);
        }
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: 'Invalid Credentials !!',
            confirmBtnColor: Colors.green.shade900);
      }
    } else if (loginData.role == 'Authority') {
      var _authorityData = await _firestore
          .collection("AuthorityAuth")
          .document(loginData.adhaarNumber)
          .get();

      if (_authorityData.data != null) {
        if (_authorityData.data["password"] == loginData.password) {
          loginData.adhaarNumber = _authorityData.data["adhaarNumber"];
          loginData.password = _authorityData.data["password"];

          Navigator.pushNamed(context, AuthorityDashboard.id);
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.warning,
              title: 'Wrong Password !!',
              confirmBtnColor: Colors.green.shade900);
        }
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: 'Invalid Credentials !!',
            confirmBtnColor: Colors.green.shade900);
      }
    } else if (loginData.role == 'Ministry') {
      var _ministryData = await _firestore
          .collection("MinistryAuth")
          .document(loginData.adhaarNumber)
          .get();

      if (_ministryData.data != null) {
        if (_ministryData.data["password"] == loginData.password) {
          loginData.adhaarNumber = _ministryData.data["adhaarNumber"];
          loginData.password = _ministryData.data["password"];

          Navigator.pushNamed(context, MinistryDashboard.id);
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.warning,
              title: 'Wrong Password !!',
              confirmBtnColor: Colors.green.shade900);
        }
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: 'Invalid Credentials !!',
            confirmBtnColor: Colors.green.shade900);
      }
    }

    setState(() {
      _isSpinnerShowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.green.shade900,
      inAsyncCall: _isSpinnerShowing,
      child: Consumer<LoginData>(
        builder: (BuildContext context, LoginData loginData, Widget child) {
          return Scaffold(
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
                    CustomRadioButton(
                      horizontal: true,
                      buttonColor: Colors.white,
                      autoWidth: true,
                      height: 40,
                      enableShape: true,
                      buttonLables: ["Farmer", "Authority", "Ministry"],
                      buttonValues: ["Farmer", "Authority", "Ministry"],
                      radioButtonValue: (value) {
                        loginData.role = value;
                      },
                      selectedColor: Colors.green.shade900,
                      padding: 0,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          CustomTextField(
                            hint: 'Adhaar Number',
                            onSubmitted: (data) {
                              loginData.adhaarNumber = data;
                            },
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 2),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.lightGreen.shade100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PasswordField(
                                onSubmit: (value) {
                                  loginData.password = value;
                                },
                                onChanged: (value) {
                                  loginData.password = value;
                                },
                                color: Colors.green,
                                hasFloatingPlaceholder: true,
                              ),
                            ),
                          ),
                          CustomButton(
                            color: Colors.green.shade900,
                            onPress: () {
                              setState(() {
                                _isSpinnerShowing = true;
                              });
                              if (loginData.role == null) {
                                loginData.role = 'Farmer';
                              }
                              print(loginData.password);
                              loginUser(loginData, context);
                            },
                            text: 'Login',
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
