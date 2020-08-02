import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AuthorityDetailsInputSheet extends StatefulWidget {
  final bool isEdit;
  final DocumentSnapshot authority;

  AuthorityDetailsInputSheet({this.isEdit, this.authority});

  @override
  _AuthorityDetailsInputSheetState createState() =>
      _AuthorityDetailsInputSheetState();
}

bool _isSpinnerShowing = false;
var _firestore = Firestore.instance;
String name,
    phoneNumber,
    password,
    adhaarNumber,
    state,
    city,
    district,
    village;

class _AuthorityDetailsInputSheetState
    extends State<AuthorityDetailsInputSheet> {
  Future<void> sendAuthorityData() async {
    setState(() {
      _isSpinnerShowing = true;
    });

    try {
      await _firestore
          .collection('AuthorityAuth')
          .document(adhaarNumber ?? widget.authority.documentID)
          .setData({
        'name': name ?? widget.authority.data['name'],
        'password': password,
        'adhaarNumber': adhaarNumber ?? widget.authority.data['adhaarNumber'],
        'phoneNumber': phoneNumber,
        'city': city,
        'state': state,
        'district': district,
        'village': village
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
            !widget.isEdit
                ? CustomTextField(
                    hint: 'Name',
                    onSubmitted: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  )
                : SizedBox(height: 0),
            !widget.isEdit
                ? CustomTextField(
                    hint: 'Adhaar Number',
                    onSubmitted: (value) {
                      setState(() {
                        adhaarNumber = value;
                      });
                    },
                  )
                : SizedBox(height: 0),
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
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black26),
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightGreen.shade100,
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
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
                            items: [
                              DropdownMenuItem(
                                child: Text('Punjab'),
                                value: 'punjab',
                              )
                            ],
                            hint: "State",
                            searchHint: "Select State",
                            onChanged: (value) {
                              setState(() {
                                state = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
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
                            items: [
                              DropdownMenuItem(
                                child: Text('Jalandhar'),
                                value: 'jalandhar',
                              )
                            ],
                            hint: "City",
                            searchHint: "Select City",
                            onChanged: (value) {
                              setState(() {
                                city = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
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
                            items: [
                              DropdownMenuItem(
                                child: Text('Jalandhar'),
                                value: 'jalandhar',
                              )
                            ],
                            hint: "District",
                            searchHint: "Select District",
                            onChanged: (value) {
                              setState(() {
                                district = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
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
                            items: [
                              DropdownMenuItem(
                                child: Text('Kahlon'),
                                value: 'kahlon',
                              )
                            ],
                            hint: "Village",
                            searchHint: "Select Village",
                            onChanged: (value) {
                              setState(() {
                                village = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                color: Colors.green.shade900,
                text: 'Submit',
                onPress: () {
                  //TODO: Firebase send data

                  if (widget.authority == null) {
                    if (name != null &&
                        adhaarNumber != null &&
                        password != null &&
                        phoneNumber != null &&
                        state != null &&
                        city != null &&
                        village != null &&
                        district != null) {
                      sendAuthorityData();
                    } else {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          title: 'Please enter all fields !!',
                          confirmBtnColor: Colors.green.shade900);
                    }
                  } else {
                    if (password != null &&
                        phoneNumber != null &&
                        state != null &&
                        city != null &&
                        village != null &&
                        district != null) {
                      sendAuthorityData();
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
  }
}
