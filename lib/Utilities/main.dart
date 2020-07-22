import 'package:agri_loco/Models/FarmerRegData.dart';
import 'package:agri_loco/Models/LoginData.dart';
import 'package:agri_loco/Screens/AuthScreens/LoginScreen.dart';
import 'package:agri_loco/Screens/AuthScreens/RegistrationScreen.dart';
import 'package:agri_loco/Screens/AuthScreens/WelcomeScreen.dart';
import 'package:agri_loco/Screens/Dashboards/AuthorityDashboard.dart';
import 'package:agri_loco/Screens/Dashboards/FarmerDashboard.dart';
import 'package:agri_loco/Screens/Dashboards/MinistryDashboard.dart';
import 'package:agri_loco/Utilities/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FarmerRegData>(
          create: (BuildContext context) {
            return FarmerRegData();
          },
        ),
        ChangeNotifierProvider<LoginData>(
          create: (BuildContext context) {
            return LoginData();
          },
        )
      ],
      child: AgriLoco(),
    ),
  );
}

class AgriLoco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        FarmerDashboard.id: (context) => FarmerDashboard(),
        AuthorityDashboard.id: (context) => AuthorityDashboard(),
        MinistryDashboard.id: (context) => MinistryDashboard(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
