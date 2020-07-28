import 'package:agri_loco/Components/CustomFarmerFieldTile.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:agri_loco/Screens/InputSheets/FieldDetailsInputSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

var _fireStore = Firestore.instance;
bool _isSpinnerShowing = false;

class FarmerDashboard extends StatefulWidget {
  static const String id = 'farmerDashboardId';

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  Future<void> deleteField(LoginData loginData, DocumentSnapshot field) async {
    setState(() {
      _isSpinnerShowing = true;
    });
    await _fireStore
        .collection('FieldsData')
        .document(field.documentID)
        .delete();

    setState(() {
      _isSpinnerShowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.confirm,
            confirmBtnColor: Colors.green.shade900,
            title: 'Do you want to Exit ?',
            confirmBtnText: 'Yes',
            showCancelBtn: true,
            cancelBtnText: 'No',
            onConfirmBtnTap: () {
              return SystemNavigator.pop();
            });
        return null;
      },
      child: Consumer<LoginData>(
          builder: (BuildContext context, LoginData loginData, Widget child) {
        return ModalProgressHUD(
          inAsyncCall: _isSpinnerShowing,
          child: MaterialApp(
              home: Scaffold(
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
            backgroundColor: Colors.greenAccent,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green.shade900,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return FieldDetailsInputSheet();
                    });
              },
              child: Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('FieldsData').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var fields = snapshot.data.documents;
                List<CustomFarmerFieldTile> fieldsList = [];

                for (var field in fields) {
                  if (field.data['ownerId'] == loginData.adhaarNumber) {
                    fieldsList.add(CustomFarmerFieldTile(
                        onEditClicked: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FieldDetailsInputSheet();
                              });
                        },
                        onDeleteClicked: () {
                          deleteField(loginData, field);
                        },
                        isVerified: field.data['isVerified'],
                        khasraNumber: field.documentID,
                        cropType: field.data['cropType'],
                        fieldSize: field.data['fieldSize'],
                        waterSource: field.data['waterSource']));
                  }
                }
                return ListView(
                  children: fieldsList,
                );
              },
            ),
          )),
        );
      }),
    );
  }
}