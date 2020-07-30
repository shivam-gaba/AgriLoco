import 'package:flutter/material.dart';

import 'CustomButton.dart';

class CustomAuthorityFarmerTile extends StatelessWidget {
  final Function onVerifyClicked;
  final Function onRemoveClicked;
  final String name,
      adhaarNumber,
      phoneNumber,
      numberOfFields,
      city,
      state,
      village,
      district;
  final List<dynamic> khasraNumberList;

  CustomAuthorityFarmerTile(
      {this.onVerifyClicked,
      this.onRemoveClicked,
      this.name,
      this.adhaarNumber,
      this.phoneNumber,
      this.numberOfFields,
      this.city,
      this.state,
      this.village,
      this.district,
      this.khasraNumberList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title:
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(name),
            ),
            ListTile(
              title: Text('Adhaar Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(adhaarNumber),
            ),
            ListTile(
              title: Text('Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '$village${district == city ? '' : ' , $district'} , $city , $state'),
            ),
            ListTile(
              title: Text('Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(phoneNumber),
            ),
            ListTile(
              title: Text('Number Of  Fields',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(numberOfFields),
            ),
            ListTile(
              title: Text('Khasra Numbers',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(khasraNumberList.toString()),
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
