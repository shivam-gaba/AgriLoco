import 'package:flutter/material.dart';

import 'CustomButton.dart';

class CustomAuthorityFieldTile extends StatelessWidget {
  final Function onVerifyClicked;
  final Function onRemoveClicked;
  final String cropType, fieldSize, waterSource, khasraNumber;

  CustomAuthorityFieldTile(
      {this.onVerifyClicked,
      this.onRemoveClicked,
      this.cropType,
      this.fieldSize,
      this.waterSource,
      this.khasraNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('Khasra Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(khasraNumber),
            ),
            ListTile(
              title: Text('Crop Type',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(cropType),
            ),
            ListTile(
              title: Text('Water Source',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(waterSource),
            ),
            ListTile(
              title: Text('Field Size',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(fieldSize),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomButton(
                    color: Colors.green,
                    text: 'Verify',
                    onPress: onVerifyClicked,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    color: Colors.red,
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
