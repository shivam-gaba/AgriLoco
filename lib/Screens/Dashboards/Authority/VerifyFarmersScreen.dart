import 'package:agri_loco/Components/CustomAuthorityFarmerTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _isSpinnerShowing = false;
var _fireStore = Firestore.instance;

class VerifyFarmersScreen extends StatefulWidget {
  @override
  _VerifyFarmersScreenState createState() => _VerifyFarmersScreenState();
}

class _VerifyFarmersScreenState extends State<VerifyFarmersScreen> {
  void verifyFarmer(DocumentSnapshot farmer) async {
    setState(() {
      _isSpinnerShowing = true;
    });

    await _fireStore
        .collection('FarmerAuth')
        .document(farmer.documentID)
        .updateData({'isVerified': true});

    setState(() {
      _isSpinnerShowing = false;
    });
  }

  void removeFarmer(DocumentSnapshot farmer) async {
    setState(() {
      _isSpinnerShowing = true;
    });

    await _fireStore
        .collection('FarmerAuth')
        .document(farmer.documentID)
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
        stream: _fireStore.collection('FarmerAuth').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No New User Found',
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            var farmers = snapshot.data.documents;
            List<CustomAuthorityFarmerTile> farmersList = [];

            for (var farmer in farmers) {
              if (farmer.data['isVerified'] == false) {
                farmersList.add(CustomAuthorityFarmerTile(
                  name: farmer.data['name'] ?? '',
                  phoneNumber: farmer.data['phoneNumber'] ?? '',
                  adhaarNumber: farmer.data['adhaarNumber'] ?? '',
                  city: farmer.data['city'] ?? '',
                  state: farmer.data['state'] ?? '',
                  district: farmer.data['district'] ?? '',
                  village: farmer.data['village'] ?? '',
                  numberOfFields: farmer.data['numberOfFields'] ?? '',
                  khasraNumberList: farmer.data['khasraNumberList'] ?? [],
                  onVerifyClicked: () {
                    verifyFarmer(farmer);
                  },
                  onRemoveClicked: () {
                    removeFarmer(farmer);
                  },
                ));
              }
            }

            if (farmersList.isEmpty) {
              return Center(
                child: Text(
                  'No New User Found',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            } else {
              return ListView(
                children: farmersList,
              );
            }
          }
        },
      ),
    );
  }
}
