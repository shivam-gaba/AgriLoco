import 'package:agri_loco/Components/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _isSpinnerShowing = false;
bool _isAddFieldButtonVisible = true;
bool _isMarkerBannerVisible = false;
bool _isMapMarkable = false;
Set<Marker> _markersSet = Set<Marker>();
List<GeoPoint> latLngList = [];
Position _currentPosition;
Geolocator _geoLocator;
var _firestore = Firestore.instance;

class GoogleMapsScreen extends StatefulWidget {
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  void getCurrentLocation() async {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  void onMapTapped(LatLng latLng) {
    if (_isMapMarkable) {
      setState(() {
        latLngList.add(GeoPoint(latLng.latitude, latLng.longitude));
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
      latLngList.clear();
      _isMapMarkable = false;
      _isMarkerBannerVisible = false;
      _isAddFieldButtonVisible = true;
    });
  }

  void onConfirmTapped() async {
    if (_markersSet.length < 3) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: '',
          text: 'Please Mark Atleast 3 Locations on Map !!',
          confirmBtnColor: Colors.green.shade900);
    } else {
      setState(() {
        _isSpinnerShowing = true;
      });

      await _firestore
          .collection('FieldsData')
          .document('126')
          .updateData({'fieldGeoPoints': latLngList});

      await _firestore
          .collection('FieldsData')
          .document('126')
          .updateData({'isVerified': true});

      setState(() {
        _isSpinnerShowing = false;
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
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
}
