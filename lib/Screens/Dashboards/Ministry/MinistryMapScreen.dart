import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MinistryMapScreen extends StatefulWidget {
  final Position currentPosition;
  MinistryMapScreen({this.currentPosition});

  @override
  _MinistryMapScreenState createState() => _MinistryMapScreenState();
}

bool _isSpinnerShowing = false;

Firestore _firestore = Firestore.instance;
List<List<dynamic>> fieldsGeoPointsList = [];
Set<dynamic> polygons = Set<Polygon>();
List<List<LatLng>> fieldsLatLngsList = [];

class _MinistryMapScreenState extends State<MinistryMapScreen> {
  Color getCropColor(String fieldName) {
    switch (fieldName.toLowerCase()) {
      case 'wheat':
        return Colors.red;

      case 'maize':
        return Colors.blue;

      case 'rice':
        return Colors.yellow;

      case 'sweetcorn':
        return Colors.brown;

      default:
        return Colors.black54;
    }
  }

  void getPolygons() async {
    var queries = await _firestore.collection('FieldsData').getDocuments();
    var documents = queries.documents;
    List<dynamic> cropNames = [];

    //Here we got list of all geoPointLists
    for (var document in documents) {
      if (document.data['fieldGeoPoints'] != null &&
          document.data['isVerified'] == true) {
        fieldsGeoPointsList.add(document.data['fieldGeoPoints']);
        cropNames.add(document.data['cropType']);
      }
    }

    fieldsLatLngsList = List.generate(fieldsGeoPointsList.length,
        (index) => List(fieldsGeoPointsList[index].length),
        growable: true);

    for (int i = 0; i < fieldsGeoPointsList.length; i++) {
      for (int j = 0; j < fieldsGeoPointsList[i].length; j++) {
        fieldsLatLngsList[i][j] = (LatLng(fieldsGeoPointsList[i][j].latitude,
            fieldsGeoPointsList[i][j].longitude));
      }
    }

    for (int i = 0; i < fieldsLatLngsList.length; i++) {
      polygons.add(Polygon(
        strokeWidth: 0,
        fillColor: getCropColor(cropNames[i]).withOpacity(0.8),
        points: fieldsLatLngsList[i],
        polygonId: PolygonId(fieldsLatLngsList[i].toString()),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldsGeoPointsList.clear();
    polygons.clear();
    fieldsLatLngsList.clear();
    getPolygons();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: GoogleMap(
        compassEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        polygons: polygons,
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
