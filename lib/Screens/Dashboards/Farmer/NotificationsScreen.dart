import 'package:agri_loco/Components/MessageTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notifications_active),
        backgroundColor: Colors.green.shade900,
        title: Text('Notifications',
            style: GoogleFonts.indieFlower(
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        color: Colors.greenAccent,
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Messages').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Notification Found',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            }

            var messages = snapshot.data.documents;
            List<MessageTile> messagesList = [];

            for (var message in messages) {
              print(message['Message'].toString());
              messagesList.add(MessageTile(
                message: message['message'].toString(),
                sender: message['sender'].toString(),
                time: message['time'].toString(),
              ));
            }

            if (messagesList.isEmpty) {
              return Center(
                child: Text(
                  'No Notifications Found',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );
            }

            return ListView(
              children: messagesList,
            );
          },
        ),
      ),
    );
  }
}
