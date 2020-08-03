import 'package:agri_loco/Components/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ResetSeasonScreen extends StatefulWidget {
  @override
  _ResetSeasonScreenState createState() => _ResetSeasonScreenState();
}

bool _isSpinnerShowing = false;
bool _alertShown = false;
String _state;

class _ResetSeasonScreenState extends State<ResetSeasonScreen> {
  void resetData() async {
    setState(() {
      _isSpinnerShowing = true;
    });

    var _firestore = Firestore.instance;

    await for (var snapshot
        in _firestore.collection('FieldsData').snapshots()) {
      for (var document in snapshot.documents) {
        if (document.data['state'].toString().toLowerCase() == _state) {
          await _firestore
              .collection('FieldsData')
              .document(document.documentID)
              .updateData({'isVerified': false}).then((value) {
            setState(() {
              _isSpinnerShowing = false;
            });

            if (!_alertShown) {
              _alertShown = true;
              CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                confirmBtnColor: Colors.green.shade900,
                title: 'Data Reset Successful!! ',
              );
            }
          });
        }
      }

      if (!_alertShown) {
        _alertShown = true;
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          confirmBtnColor: Colors.green.shade900,
          title: 'Data Reset Successful!! ',
        );
      }

      setState(() {
        _isSpinnerShowing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                ),
                DropdownMenuItem(
                  child: Text('Haryana'),
                  value: 'haryana',
                ),
                DropdownMenuItem(
                  child: Text('Himachal'),
                  value: 'himachal',
                ),
              ],
              hint: "Select State",
              searchHint: "Select State",
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
              isExpanded: true,
            ),
          ),
          CustomButton(
            color: Colors.green.shade900,
            onPress: () {
              if (_state == null) {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  confirmBtnColor: Colors.green.shade900,
                  title: 'Please select state !!',
                );
              } else {
                _alertShown = false;
                resetData();
              }
            },
            text: 'Reset Data',
          )
        ],
      ),
    );
  }
}
