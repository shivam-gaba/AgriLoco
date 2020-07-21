import 'package:flutter/material.dart';

class FarmerDashboard extends StatefulWidget {
  static const String id = 'farmerDashboardId';

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(child: Text('Farmer')),
    ));
  }
}
