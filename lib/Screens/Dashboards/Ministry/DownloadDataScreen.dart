import 'package:agri_loco/Components/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DownloadDataScreen extends StatefulWidget {
  @override
  _DownloadDataScreenState createState() => _DownloadDataScreenState();
}

var _firestore = Firestore.instance;
bool _isSpinnerShowing = false;

class _DownloadDataScreenState extends State<DownloadDataScreen> {
  Future<dynamic> getData() async {}

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Container(),
    );
  }
}
