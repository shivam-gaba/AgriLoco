import 'package:agri_loco/Components/CustomButton.dart';
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

bool _isSpinnerShowing = false;
int _currentPage = 1;
Position _currentPosition;
Geolocator _geoLocator;
bool _isAddFieldButtonVisible = true;
bool _isMarkerBannerVisible = false;
bool _isMapMarkable = false;
Set<Marker> _markersSet = Set<Marker>();

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
                mapType: MapType.hybrid,
                markers: _markersSet,
                onTap: _isMapMarkable
                    ? (LatLng choosedLatLng) {
                        setState(() {
                          _markersSet.add(
                            Marker(
                              position: choosedLatLng,
                              markerId: MarkerId(
                                choosedLatLng.toString(),
                              ),
                            ),
                          );
                        });
                      }
                    : null,
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
                            _isMapMarkable = true;
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
                                  onPressed: () {},
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
                                  onPressed: () {
                                    setState(() {
                                      _markersSet.clear();
                                      _isAddFieldButtonVisible = true;
                                      _isMarkerBannerVisible = false;
                                      _isMapMarkable = false;
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
