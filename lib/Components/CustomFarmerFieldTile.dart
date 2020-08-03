import 'package:agri_loco/Components/CustomButton.dart';
import 'package:flutter/material.dart';

class CustomFarmerFieldTile extends StatelessWidget {
  final Function onDeleteClicked;
  final Function onEditClicked;
  final String cropType;
  final String khasraNumber;
  final String fieldSize;
  final String waterSource;
  final bool isVerified;

  CustomFarmerFieldTile(
      {this.isVerified,
      this.onDeleteClicked,
      this.onEditClicked,
      this.cropType,
      this.khasraNumber,
      this.fieldSize,
      this.waterSource});

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
            Container(
              decoration: BoxDecoration(
                color: isVerified ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: ListTile(
                  title: Text(
                    isVerified ? 'Verified' : 'Not Verified',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  trailing: isVerified
                      ? Icon(
                          Icons.verified_user,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
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
                    color: Colors.green.shade900,
                    text: 'Edit',
                    onPress: onEditClicked,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    color: Colors.green.shade900,
                    text: 'Delete',
                    onPress: onDeleteClicked,
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
