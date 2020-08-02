import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _isSpinnerShowing = false;
Set<Marker> _markersSet = Set<Marker>();
List<GeoPoint> _latLngList = [];

var _firestore = Firestore.instance;

class AuthorityMapsScreen extends StatefulWidget {
  static const String id = 'mapScreenId';
  final String khasraNumber;
  final Position currentPosition;

  AuthorityMapsScreen({@required this.khasraNumber, this.currentPosition});

  @override
  _AuthorityMapsScreenState createState() => _AuthorityMapsScreenState();
}

class _AuthorityMapsScreenState extends State<AuthorityMapsScreen> {
  void onMapTapped(LatLng latLng) {
    setState(() {
      _latLngList.add(GeoPoint(latLng.latitude, latLng.longitude));
      _markersSet.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      ));
    });
  }

  void onCancelTapped() {
    setState(() {
      _markersSet.clear();
      _latLngList.clear();
    });
    Navigator.pop(context);
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
          .document(widget.khasraNumber)
          .updateData({'fieldGeoPoints': _latLngList});

      await _firestore
          .collection('FieldsData')
          .document(widget.khasraNumber)
          .updateData({'isVerified': true});

      setState(() {
        _isSpinnerShowing = false;
      });
    }
    _markersSet.clear();
    _latLngList.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _isSpinnerShowing,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                myLocationButtonEnabled: true,
                compassEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.hybrid,
                markers: _markersSet,
                onTap: onMapTapped,
                initialCameraPosition: CameraPosition(
                    zoom: 7,
                    target: LatLng(
                        widget.currentPosition != null
                            ? widget.currentPosition.latitude
                            : 30.5937,
                        widget.currentPosition != null
                            ? widget.currentPosition.longitude
                            : 78.9629)),
              ),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
