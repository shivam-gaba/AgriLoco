import 'package:agri_loco/Screens/LoginScreen.dart';
import 'package:agri_loco/Screens/RegisterationScreen.dart';
import 'package:agri_loco/Screens/WelcomeScreen.dart';
import 'package:agri_loco/Utilities/Constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(AgriLoco());

class AgriLoco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
