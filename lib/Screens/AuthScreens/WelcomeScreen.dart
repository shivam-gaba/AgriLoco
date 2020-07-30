import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginScreen.dart';
import 'RegistrationScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcomeScreenId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        leading: Icon(Icons.filter_hdr),
        backgroundColor: Colors.green.shade900,
        title: Text('AGRI LOCO',
            style: GoogleFonts.indieFlower(
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTitle(
              title: 'AGRI-LOCO',
            ),
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
    );
  }
}
