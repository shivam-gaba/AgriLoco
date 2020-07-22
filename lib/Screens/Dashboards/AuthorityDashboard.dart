import 'package:agri_loco/Models/LoginData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

bool _isSpinnerShowing = false;
var _fireStore = Firestore.instance;
int currentPage = 1;

class AuthorityDashboard extends StatefulWidget {
  static const String id = 'authorityDashboardId';

  @override
  _AuthorityDashboardState createState() => _AuthorityDashboardState();
}

class _AuthorityDashboardState extends State<AuthorityDashboard> {
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
        return;
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
                bottomNavigationBar: FancyBottomNavigation(
                  textColor: Colors.white,
                  circleColor: Colors.greenAccent,
                  activeIconColor: Colors.green.shade900,
                  inactiveIconColor: Colors.greenAccent,
                  barBackgroundColor: Colors.green.shade900,
                  initialSelection: 1,
                  tabs: [
                    TabData(iconData: Icons.verified_user, title: "Farmers"),
                    TabData(iconData: Icons.home, title: "Home"),
                    TabData(iconData: Icons.filter_hdr, title: "Crops")
                  ],
                  onTabChangedListener: (position) {
                    setState(() {
                      currentPage = position;
                    });
                  },
                ),
                backgroundColor: Colors.greenAccent,
                body: getCurrentPage(currentPage),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getCurrentPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return Container(
          //Farmers
          color: Colors.red,
        );
      case 1:
        return Container(
          //Map
          color: Colors.blue,
        );
      case 2:
        return Container(
          //Crops
          color: Colors.yellow,
        );
      default:
        return null;
    }
  }
}
