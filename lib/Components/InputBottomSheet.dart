import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:flutter/material.dart';

class InputBottomSheet extends StatefulWidget {
  final String name,
      address,
      phoneNumber,
      adhaarNumber,
      password,
      numberOfFields;

  InputBottomSheet(
      {this.numberOfFields,
      this.password,
      this.address,
      this.adhaarNumber,
      this.name,
      this.phoneNumber});

  @override
  _InputBottomSheetState createState() => _InputBottomSheetState();
}

class _InputBottomSheetState extends State<InputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Column(
            children: <Widget>[
              Text(
                'Enter Khasra Numbers',
                style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: (widget.numberOfFields) != null
                        ? int.parse(widget.numberOfFields)
                        : 0,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomTextField(
                        hint: 'Enter Khasra Number',
                        onSubmitted: (value) {
                          //TODO: put data in list
                        },
                      );
                    }),
              ),
              CustomButton(
                color: Colors.green.shade900,
                onPress: () {
                  //TODO: Firebase Register
                },
                text: 'Submit',
              ),
            ],
          ),
        ));
  }
}
