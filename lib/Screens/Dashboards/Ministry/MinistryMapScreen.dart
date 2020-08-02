import 'package:cloud_firestore/cloud_firestore.dart';
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
      child: GoogleMap(
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
    );
  }
}
