import 'package:agri_loco/Screens/Dashboards/Ministry/AuthorityAccountsScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/MapHistoryInputScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/MinistryMapScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/InputWaterReportScreen.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/ResetSeasonScreen.dart';
import 'package:agri_loco/Screens/SendNotificationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MinistryDashboard extends StatefulWidget {
  static const String id = 'ministryDashboardId';

  @override
  _MinistryDashboardState createState() => _MinistryDashboardState();
}

Geolocator _geoLocator;
Position _currentPosition;
int _currentPage = 0;
List<List<dynamic>> _fieldsGeoPointsList = [];
Set<dynamic> _polygons = Set<Polygon>();
List<List<LatLng>> _fieldsLatLngsList = [];
Firestore _firestore = Firestore.instance;

void getPolygons() async {
  var queries = await _firestore.collection('FieldsData').getDocuments();
  var documents = queries.documents;
  List<dynamic> cropNames = [];

  //Here we got list of all geoPointLists
  for (var document in documents) {
    if (document.data['fieldGeoPoints'] != null &&
        document.data['isVerified'] == true) {
      _fieldsGeoPointsList.add(document.data['fieldGeoPoints']);
      cropNames.add(document.data['cropType']);
    }
  }

  _fieldsLatLngsList = List.generate(_fieldsGeoPointsList.length,
      (index) => List(_fieldsGeoPointsList[index].length),
      growable: true);

  for (int i = 0; i < _fieldsGeoPointsList.length; i++) {
    for (int j = 0; j < _fieldsGeoPointsList[i].length; j++) {
      _fieldsLatLngsList[i][j] = (LatLng(_fieldsGeoPointsList[i][j].latitude,
          _fieldsGeoPointsList[i][j].longitude));
    }
  }

  for (int i = 0; i < _fieldsLatLngsList.length; i++) {
    _polygons.add(Polygon(
      strokeWidth: 0,
      fillColor: getCropColor(cropNames[i]).withOpacity(0.8),
      points: _fieldsLatLngsList[i],
      polygonId: PolygonId(_fieldsLatLngsList[i].toString()),
    ));
  }
}

Color getCropColor(String fieldName) {
  switch (fieldName.toLowerCase()) {
    case 'greengram':
      return Colors.red;

    case 'maize':
      return Colors.blue;

    case 'chick pea':
      return Colors.yellow;

    case 'black gram/gram/urd':
      return Colors.brown;

    default:
      return Colors.black54;
  }
}

void getCurrentLocation() async {
  //Gets Current Location with help of GeoLocator library
  _geoLocator = Geolocator()..forceAndroidLocationManager;

  _currentPosition = await _geoLocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
}

class _MinistryDashboardState extends State<MinistryDashboard> {
  void menuItemSelected(String option) {
    switch (option) {
      case 'Send Notification':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SendNotificationScreen('Ministry')));
        break;

      case 'Logout':
        Navigator.pop(context);
        break;

      case 'Map History':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapHistoryInputSheet()));
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    _fieldsGeoPointsList.clear();
    _polygons.clear();
    _fieldsLatLngsList.clear();
    getPolygons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: menuItemSelected,
            itemBuilder: (BuildContext context) {
              return {'Send Notification', 'Map History', 'Logout'}
                  .map((String choice) {
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
          TabData(iconData: Icons.person_add, title: "Authorities"),
          TabData(iconData: Icons.location_city, title: "Map"),
          TabData(iconData: Icons.cloud_download, title: "Water Report"),
          TabData(
              iconData: Icons.settings_backup_restore, title: "Reset season"),
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
        return MinistryMapScreen(
          currentPosition: _currentPosition,
          polygons: _polygons,
        );

      case 2:
        return InputWaterReportScreen();

      case 3:
        return ResetSeasonScreen();
    }
  }
}
