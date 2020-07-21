import 'package:flutter/material.dart';

class AuthorityDashboard extends StatefulWidget {
  static const String id = 'authorityDashboardId';

  @override
  _AuthorityDashboardState createState() => _AuthorityDashboardState();
}

class _AuthorityDashboardState extends State<AuthorityDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(child: Text('Authority')),
    ));
  }
}
