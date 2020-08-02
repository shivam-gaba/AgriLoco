import 'package:agri_loco/Components/CustomAuthorityTile.dart';
import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Screens/InputSheets/AuthorityDetailsInputSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AuthorityAccountsScreen extends StatefulWidget {
  @override
  _AuthorityAccountsScreenState createState() =>
      _AuthorityAccountsScreenState();
}

bool _isSpinnerShowing = false;
var _fireStore = Firestore.instance;

class _AuthorityAccountsScreenState extends State<AuthorityAccountsScreen> {
  void removeAuthority(DocumentSnapshot authority) async {
    setState(() {
      _isSpinnerShowing = true;
    });

    _fireStore
        .collection('AuthorityAuth')
        .document(authority.documentID)
        .delete();

    setState(() {
      _isSpinnerShowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Column(
        children: <Widget>[
          CustomButton(
            color: Colors.green.shade900,
            text: 'Add a new Authority',
            onPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AuthorityDetailsInputSheet(
                      isEdit: false,
                      authority: null,
                    );
                  });
            },
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('AuthorityAuth').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var authorities = snapshot.data.documents;
                    List<CustomAuthorityTile> authorityList = [];

                    for (var authority in authorities) {
                      authorityList.add(CustomAuthorityTile(
                        name: authority.data['name'],
                        phoneNumber: authority.data['phoneNumber'],
                        adhaarNumber: authority.data['adhaarNumber'],
                        password: authority.data['password'],
                        onEditClicked: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return AuthorityDetailsInputSheet(
                                  isEdit: true,
                                  authority: authority,
                                );
                              });
                        },
                        onRemoveClicked: () {
                          removeAuthority(authority);
                        },
                      ));
                    }

                    return ListView(
                      children: authorityList,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
