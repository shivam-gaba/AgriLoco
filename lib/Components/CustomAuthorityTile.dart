import 'package:flutter/material.dart';
import 'CustomButton.dart';

class CustomAuthorityTile extends StatelessWidget {
  final String name, phoneNumber, adhaarNumber, password;
  final Function onEditClicked, onRemoveClicked;

  CustomAuthorityTile(
      {this.name,
      this.phoneNumber,
      this.adhaarNumber,
      this.password,
      this.onEditClicked,
      this.onRemoveClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.contact_mail,
                color: Colors.green,
              ),
              title:
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(name),
            ),
            ListTile(
              leading: Icon(
                Icons.confirmation_number,
                color: Colors.green,
              ),
              title: Text('Adhaar Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(adhaarNumber),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone,
                color: Colors.green,
              ),
              title: Text('Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(phoneNumber),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomButton(
                    color: Colors.green.shade900,
                    text: 'Edit',
                    onPress: onEditClicked,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CustomButton(
                    color: Colors.green.shade900,
                    text: 'Remove',
                    onPress: onRemoveClicked,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
