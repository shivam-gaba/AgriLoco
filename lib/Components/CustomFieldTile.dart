import 'package:agri_loco/Components/CustomButton.dart';
import 'package:flutter/material.dart';

class CustomFieldTile extends StatelessWidget {
  final Function onDeleteClicked;
  final Function onEditClicked;
  final String cropType;
  final String khasraNumber;
  final String fieldSize;
  final String waterSource;

  CustomFieldTile(
      {this.onDeleteClicked,
      this.onEditClicked,
      this.cropType,
      this.khasraNumber,
      this.fieldSize,
      this.waterSource});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Khasra Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Crop Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Water Source',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Field Size',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(khasraNumber),
                        Text(cropType),
                        Text(waterSource),
                        Text(fieldSize),
                      ],
                    ),
                  ),
                ),
              ],
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
