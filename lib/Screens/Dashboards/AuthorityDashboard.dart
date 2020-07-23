import 'package:agri_loco/Components/CustomButton.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

bool _isSpinnerShowing = false;
var _fireStore = Firestore.instance;
int _currentPage = 1;
Position _currentPosition;
Geolocator _geoLocator;
bool _isAddFieldButtonVisible = true;
bool _isMarkerBannerVisible = false;

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
      _isSpinnerShowing = true;
    });
    //Gets Current Location with help of GeoLocator library
    _geoLocator = Geolocator()..forceAndroidLocationManager;
    _currentPosition = await _geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    setState(() {
      _isSpinnerShowing = false;
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
      child: Consumer(
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

  Widget getCurrentPage(int pageNumber) {
    switch (pageNumber) {
      case 0:
        //Farmer
        return Container();
      case 1:
        return ModalProgressHUD(
          inAsyncCall: _isSpinnerShowing,
          child: Stack(
            children: <Widget>[
              GoogleMap(
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
                        onPress: () {
                          setState(() {
                            _isAddFieldButtonVisible = false;
                            _isMarkerBannerVisible = true;
                          });

                          //Mark Markers
                          //Show a confirm Button on >3 markers
                          //Show a dialog box to fill details of that area
                          //Upload on firebase
                          //Show coloured area on map
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isMarkerBannerVisible,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Tap on Map to Add Markers',
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _isAddFieldButtonVisible = true;
                                _isMarkerBannerVisible = false;
                              });
                            },
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
              )
            ],
          ),
        );
      case 2:
        return Container(
            //Crops
            );
      default:
        return Container(
          color: Colors.lightGreen,
        );
    }
  }
}
