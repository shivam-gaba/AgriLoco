import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SendNotificationScreen extends StatefulWidget {
  static const String id = 'sendNotificationScreenId';

  final String role;
  SendNotificationScreen(this.role);

  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

bool _isSpinnerShowing = false;

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  String message;

  void sendMessage() async {
    setState(() {
      _isSpinnerShowing = true;
    });

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    var _firestore = Firestore.instance;
    await _firestore.collection('Messages').add({
      'message': message,
      'time': formattedDate,
      'sender': widget.role
    }).then((value) => CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Notification Sent',
        confirmBtnColor: Colors.green.shade900));

    setState(() {
      _isSpinnerShowing = false;
    });
  }

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
      body: ModalProgressHUD(
        inAsyncCall: _isSpinnerShowing,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                hint: 'Enter Message',
                inputType: TextInputType.text,
                onSubmitted: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                color: Colors.green.shade900,
                text: 'Send',
                onPress: () {
                  if (message == null) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        title: 'Enter Message',
                        confirmBtnColor: Colors.green.shade900);
                  } else {
                    sendMessage();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
