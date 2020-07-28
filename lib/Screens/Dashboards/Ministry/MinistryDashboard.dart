import 'package:agri_loco/Screens/Dashboards/Ministry/MinistryMapScreen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MinistryDashboard extends StatefulWidget {
  static const String id = 'ministryDashboardId';

  @override
  _MinistryDashboardState createState() => _MinistryDashboardState();
}

int _currentPage = 0;

class _MinistryDashboardState extends State<MinistryDashboard> {
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
            tabs: [
              TabData(iconData: Icons.location_city, title: "Map"),
              TabData(iconData: Icons.filter_hdr, title: "Temp"),
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
      ),
    );
  }

  // ignore: missing_return
  Widget getCurrentPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return MinistryMapScreen();
      case 1:
        return Container();
    }
  }
}
