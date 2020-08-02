import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:agri_loco/Utilities/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FieldDetailsInputSheet extends StatefulWidget {
  final bool isEdit;
  final DocumentSnapshot field;
  FieldDetailsInputSheet({this.isEdit, this.field});

  @override
  _FieldDetailsInputSheetState createState() => _FieldDetailsInputSheetState();
}

bool _isSpinnerShowing = false;
List<DropdownMenuItem> cropsList = [];

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
          .document(khasraNumber ?? widget.field.documentID)
          .setData({
        'ownerId': loginData.adhaarNumber,
        'isVerified': false,
        'cropType': cropType,
        'fieldSize': '$fieldSize yards',
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
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < crops.length; i++) {
      cropsList.add(DropdownMenuItem(
        child: Text(crops[i]),
        value: crops[i],
      ));
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
              !widget.isEdit
                  ? CustomTextField(
                      hint: 'Khasra Number',
                      inputType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() {
                          khasraNumber = value;
                        });
                      },
                    )
                  : SizedBox(
                      height: 0,
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
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lightGreen.shade100,
                    border: Border.all(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SearchableDropdown.single(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: Colors.green.shade900,
                      ),
                      clearIcon: Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.green.shade900,
                      ),
                      items: cropsList,
                      hint: "Select Crop Type",
                      searchHint: "Select Crop",
                      onChanged: (value) {
                        setState(() {
                          cropType = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                ),
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

                    //Add clicked
                    if (widget.field == null) {
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
                    } else {
                      if (fieldSize != null && cropType != null) {
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
                    }
                  })
            ],
          ),
        ),
      );
    });
  }
}
