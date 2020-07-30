import 'package:agri_loco/Components/CustomAuthorityFieldTile.dart';
import 'package:agri_loco/Screens/Dashboards/Authority/AuthorityMapsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _isSpinnerShowing = false;
var _fireStore = Firestore.instance;

class VerifyFieldsScreen extends StatefulWidget {
  @override
  _VerifyFieldsScreenState createState() => _VerifyFieldsScreenState();
}

class _VerifyFieldsScreenState extends State<VerifyFieldsScreen> {
  Position _currentPosition;
  Geolocator _geoLocator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    //Gets Current Location with help of GeoLocator library
    _geoLocator = Geolocator()..forceAndroidLocationManager;

    _currentPosition = await _geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  void verifyField(DocumentSnapshot field) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthorityMapsScreen(
          khasraNumber: field.documentID,
          currentPosition: _currentPosition,
        ),
      ),
    );
  }

  void removeField(DocumentSnapshot field) async {
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
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('FieldsData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No New Crop Verifications Found',
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            var fields = snapshot.data.documents;
            List<CustomAuthorityFieldTile> fieldsList = [];

            for (var field in fields) {
              if (field.data['isVerified'] == false) {
                fieldsList.add(CustomAuthorityFieldTile(
                  onRemoveClicked: () {
                    removeField(field);
                  },
                  onVerifyClicked: () {
                    verifyField(field);
                  },
                  cropType: field.data['cropType'] ?? '',
                  waterSource: field.data['waterSource'] ?? '',
                  khasraNumber: field.documentID ?? '',
                  fieldSize: field.data['fieldSize'] ?? '',
                ));
              }
            }

            if (fieldsList.isEmpty) {
              return Center(
                child: Text(
                  'No New Crop Verifications Found',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            } else {
              return ListView(
                children: fieldsList,
              );
            }
          }
        },
      ),
    );
  }
}
