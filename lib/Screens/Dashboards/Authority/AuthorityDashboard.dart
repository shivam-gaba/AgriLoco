import 'package:agri_loco/Screens/Dashboards/Authority/VerifyFarmersScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Authority/VerifyFieldsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../SendNotificationScreen.dart';

int _currentPage = 0;

class AuthorityDashboard extends StatefulWidget {
  static const String id = 'authorityDashboardId';

  @override
  _AuthorityDashboardState createState() => _AuthorityDashboardState();
}

class _AuthorityDashboardState extends State<AuthorityDashboard> {
  void menuItemSelected(String option) {
    switch (option) {
      case 'Send Notification':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SendNotificationScreen('Authority')));
        break;

      case 'Logout':
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: menuItemSelected,
            itemBuilder: (BuildContext context) {
              return {'Send Notification', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
          TabData(iconData: Icons.filter_hdr, title: "Crops"),
          TabData(iconData: Icons.verified_user, title: "Farmers"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentPage = position;
          });
        },
      ),
      backgroundColor: Colors.greenAccent,
      body: getCurrentPage(_currentPage),
    );
  }

  // ignore: missing_return
  Widget getCurrentPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return VerifyFieldsScreen();
      case 1:
        return VerifyFarmersScreen();
    }
  }
}
