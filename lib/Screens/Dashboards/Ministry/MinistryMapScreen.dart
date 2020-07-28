import 'package:agri_loco/Screens/Dashboards/Authority/AuthorityMapsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MinistryMapScreen extends StatefulWidget {
  @override
  _MinistryMapScreenState createState() => _MinistryMapScreenState();
}

bool _isSpinnerShowing = false;
Geolocator _geoLocator;
Position _currentPosition;
Firestore _firestore = Firestore.instance;
List<List<dynamic>> fieldsGeoPointsList = [];
Set<dynamic> polygons = Set<Polygon>();
List<List<LatLng>> fieldsLatLngsList = [];

class _MinistryMapScreenState extends State<MinistryMapScreen> {
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
      fieldsGeoPointsList.add(document.data['fieldGeoPoints']);
      cropNames.add(document.data['cropType']);
    }

    fieldsLatLngsList = List.generate(
        fieldsGeoPointsList.length, (index) => List(4),
        growable: true);

    for (int i = 0; i < fieldsGeoPointsList.length; i++) {
      for (int j = 0; j < fieldsGeoPointsList[i].length; j++) {
        fieldsLatLngsList[i][j] = (LatLng(fieldsGeoPointsList[i][j].latitude,
            fieldsGeoPointsList[i][j].longitude));
      }
    }

    for (int i = 0; i < fieldsLatLngsList.length; i++) {
      polygons.add(Polygon(
        strokeWidth: 1,
        fillColor: getCropColor(cropNames[i]).withOpacity(0.7),
        points: fieldsLatLngsList[i],
        polygonId: PolygonId(fieldsLatLngsList[i].toString()),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
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
        mapType: MapType.hybrid,
        polygons: polygons,
        initialCameraPosition: CameraPosition(
            zoom: 7,
            target: LatLng(
                _currentPosition != null ? _currentPosition.latitude : 30.5937,
                _currentPosition != null
                    ? _currentPosition.longitude
                    : 78.9629)),
      ),
    );
  }
}
