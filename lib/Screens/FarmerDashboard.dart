import 'package:agri_loco/Components/CustomFieldTile.dart';
import 'package:agri_loco/Models/Field.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

var _fireStore = Firestore.instance;

class FarmerDashboard extends StatefulWidget {
  static const String id = 'farmerDashboardId';

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginData>(
        builder: (BuildContext context, LoginData loginData, Widget child) {
      return MaterialApp(
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
                  return Container();
                });
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection('FieldsData')
              .document(loginData.adhaarNumber)
              .collection('FarmerFieldData')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var fields = snapshot.data.documents;
            List<CustomFieldTile> fieldsList = [];

            for (var field in fields) {
              fieldsList.add(CustomFieldTile(
                  onEditClicked: null,
                  onDeleteClicked: null,
                  khasraNumber: field.documentID,
                  cropType: field.data['cropType'],
                  fieldSize: field.data['fieldSize'],
                  waterSource: field.data['waterSource']));
            }

            return ListView(
              children: fieldsList,
            );
          },
        ),
      ));
    });
  }
}
