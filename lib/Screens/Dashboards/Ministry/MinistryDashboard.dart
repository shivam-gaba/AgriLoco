import 'package:agri_loco/Screens/Dashboards/Ministry/AuthorityAccountsScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/MinistryMapScreen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class MinistryDashboard extends StatefulWidget {
  static const String id = 'ministryDashboardId';

  @override
  _MinistryDashboardState createState() => _MinistryDashboardState();
}

Geolocator _geoLocator;
Position _currentPosition;
int _currentPage = 0;

void getCurrentLocation() async {
  //Gets Current Location with help of GeoLocator library
  _geoLocator = Geolocator()..forceAndroidLocationManager;

  _currentPosition = await _geoLocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
}

class _MinistryDashboardState extends State<MinistryDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          TabData(iconData: Icons.person_add, title: "Authorities"),
          TabData(iconData: Icons.location_city, title: "Map"),
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
        return AuthorityAccountsScreen();
      case 1:
        return MinistryMapScreen(currentPosition: _currentPosition);
    }
  }
}
