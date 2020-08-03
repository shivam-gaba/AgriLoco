import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MinistryMapScreen extends StatefulWidget {
  final Position currentPosition;
  final Set<Polygon> polygons;
  MinistryMapScreen({this.currentPosition, this.polygons});

  @override
  _MinistryMapScreenState createState() => _MinistryMapScreenState();
}

bool _isSpinnerShowing = false;

class _MinistryMapScreenState extends State<MinistryMapScreen> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            polygons: widget.polygons,
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
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(
                color: Colors.green.shade900,
                width: 2,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            height: 120,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Wheat',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontSize: 17),
                  ),
                  trailing: Container(
                    width: 150,
                    height: 10,
                    color: Colors.red,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Maize',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontSize: 17),
                  ),
                  trailing: Container(
                    width: 150,
                    height: 10,
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Rice',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontSize: 17),
                  ),
                  trailing: Container(
                    width: 150,
                    height: 10,
                    color: Colors.yellow,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Sweet Corn',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontSize: 17),
                  ),
                  trailing: Container(
                    width: 150,
                    height: 10,
                    color: Colors.brown,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
