import 'package:agri_loco/Screens/Dashboards/Authority/VerifyFarmersScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'GoogleMapsScreen.dart';
import 'VerifyFieldsScreen.dart';

int _currentPage = 1;

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
                    _currentPage = position;
                  });
                },
              ),
              backgroundColor: Colors.greenAccent,
              body: getCurrentPage(_currentPage),
            ),
          );
        },
      ),
    );
  }

  // ignore: missing_return
  Widget getCurrentPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return VerifyFarmersScreen();
      case 1:
        return GoogleMapsScreen();
      case 2:
        return VerifyFieldsScreen();
    }
  }
}
