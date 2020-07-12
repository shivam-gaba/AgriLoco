import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Screens/LoginScreen.dart';
import 'package:agri_loco/Screens/RegisterationScreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreenId';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.filter_hdr),
          backgroundColor: Colors.green.shade900,
          title: Text(
            'AGRI LOCO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTitle(),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                text: 'Login',
                color: Colors.green.shade900,
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              CustomButton(
                text: 'Register',
                color: Colors.green.shade900,
                onPress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
