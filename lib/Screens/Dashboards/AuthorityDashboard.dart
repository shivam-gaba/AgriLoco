import 'package:agri_loco/Components/CustomAuthorityFarmerTile.dart';
import 'package:agri_loco/Components/CustomAuthorityFieldTile.dart';
import 'package:agri_loco/Components/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

//Navigation Attributes
bool _isMapSpinnerShowing = false;
int _currentPage = 1;

//Location Attributes
Position _currentPosition;
Geolocator _geoLocator;

//Maps Attributes
bool _isAddFieldButtonVisible = true;
bool _isMarkerBannerVisible = false;
bool _isMapMarkable = false;
Set<Marker> _markersSet = Set<Marker>();
Set<Polygon> _polygonsSet = Set<Polygon>();
List<LatLng> _polygonLatLngs = List<LatLng>();

var _fireStore = Firestore.instance;
bool _isFarmersSpinnerShowing = false;
bool _isCropsSpinnerShowing = false;

class AuthorityDashboard extends StatefulWidget {
  static const String id = 'authorityDashboardId';

  @override
  _AuthorityDashboardState createState() => _AuthorityDashboardState();
}

class _AuthorityDashboardState extends State<AuthorityDashboard> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    setState(() {
      _isMapSpinnerShowing = true;
    });
    //Gets Current Location with help of GeoLocator library
    _geoLocator = Geolocator()..forceAndroidLocationManager;
    _currentPosition = await _geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    setState(() {
      _isMapSpinnerShowing = false;
    });
  }

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
        return FarmersVerificationScreen();
      case 1:
        return GoogleMapScreen();
      case 2:
        return CropsVerificationScreen();
    }
  }

  // ignore: non_constant_identifier_names
  ModalProgressHUD CropsVerificationScreen() {
    return ModalProgressHUD(
      inAsyncCall: _isCropsSpinnerShowing,
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
            return ListView();
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ModalProgressHUD FarmersVerificationScreen() {
    return ModalProgressHUD(
      inAsyncCall: _isFarmersSpinnerShowing,
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
              farmersList.add(CustomAuthorityFarmerTile(
                name: farmer.data['name'],
                phoneNumber: farmer.data['phoneNumber'],
                adhaarNumber: farmer.data['adhaarNumber'],
                address: farmer.data['address'],
                numberOfFields: farmer.data['numberOfFields'],
                khasraNumberList: farmer.data['khasraNumberList'],
                onVerifyClicked: null,
                onRemoveClicked: null,
              ));
            }

            return ListView(
              children: farmersList,
            );
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ModalProgressHUD GoogleMapScreen() {
    return ModalProgressHUD(
      inAsyncCall: _isMapSpinnerShowing,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
            polygons: _polygonsSet,
            markers: _markersSet,
            onTap: onMapTapped,
            initialCameraPosition: CameraPosition(
                zoom: 6,
                target: LatLng(
                    _currentPosition != null
                        ? _currentPosition.latitude
                        : 30.5937,
                    _currentPosition != null
                        ? _currentPosition.longitude
                        : 78.9629)),
          ),
          Visibility(
            visible: _isAddFieldButtonVisible,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomButton(
                    color: Colors.green.shade900,
                    text: 'ADD A NEW FIELD',
                    onPress: onAddFieldTapped,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isMarkerBannerVisible,
            child: Container(
              height: 120,
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Tap on Map to Add Markers',
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            child: MaterialButton(
                              onPressed: onConfirmTapped,
                              child: Text('CONFIRM',
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            child: MaterialButton(
                              onPressed: onCancelTapped,
                              child: Text('CANCEL',
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void createPolygon(List<LatLng> latLngList) {
    _polygonsSet.add(Polygon(
      polygonId: PolygonId(latLngList.toString()),
      fillColor: Colors.red.withOpacity(0.50),
      strokeWidth: 0,
      points: latLngList,
    ));
  }

  void onMapTapped(LatLng latLng) {
    if (_isMapMarkable) {
      setState(() {
        _polygonLatLngs.add(latLng);
        _markersSet.add(Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
        ));
      });
    }
  }

  void onCancelTapped() {
    setState(() {
      _markersSet.clear();
      _isMapMarkable = false;
      _isMarkerBannerVisible = false;
      _isAddFieldButtonVisible = true;
    });
  }

  void onConfirmTapped() {
    if (_polygonLatLngs.length < 3) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: '',
          text: 'Please Mark Atleast 3 Locations on Map !!',
          confirmBtnColor: Colors.green.shade900);
    } else {
      setState(() {
        createPolygon(_polygonLatLngs);
        _markersSet.clear();
        _isMapMarkable = false;
        _isMarkerBannerVisible = false;
        _isAddFieldButtonVisible = true;
      });
    }
  }

  void onAddFieldTapped() {
    setState(() {
      _isMapMarkable = true;
      _isMarkerBannerVisible = true;
      _isAddFieldButtonVisible = false;
    });
  }
}
