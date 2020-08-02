import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Components/CustomTitle.dart';
import 'package:agri_loco/Models/FarmerRegData.dart';
import 'package:agri_loco/Screens/InputSheets/KhasraNumberInputSheet.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registrationScreenId';
  @override
  Widget build(BuildContext context) {
    return Consumer<FarmerRegData>(
      builder:
          (BuildContext context, FarmerRegData registrationData, Widget child) {
        return Scaffold(
          backgroundColor: Colors.greenAccent,
          appBar: AppBar(
            leading: Icon(
              Icons.filter_hdr,
            ),
            backgroundColor: Colors.green.shade900,
            title: Text('AGRI LOCO',
                style: GoogleFonts.indieFlower(
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTitle(
                    title: 'Register',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        CustomTextField(
                          hint: 'Name',
                          onSubmitted: (data) {
                            registrationData.name = data;
                          },
                        ),
                        CustomTextField(
                          hint: 'Phone Number',
                          onSubmitted: (data) {
                            registrationData.phoneNumber = data;
                          },
                        ),
                        CustomTextField(
                          hint: 'Adhaar Number',
                          onSubmitted: (data) {
                            registrationData.adhaarNumber = data;
                          },
                        ),
                        CustomTextField(
                          hint: 'Number of Fields',
                          onSubmitted: (data) {
                            registrationData.numberOfFields = data;
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 2),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightGreen.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PasswordField(
                              onSubmit: (value) {
                                registrationData.password = value;
                              },
                              onChanged: (value) {
                                registrationData.password = value;
                              },
                              color: Colors.green,
                              hasFloatingPlaceholder: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 8, right: 8, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black26),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.lightGreen.shade100,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SearchableDropdown.single(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        clearIcon: Icon(
                                          Icons.cancel,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Punjab'),
                                            value: 'punjab',
                                          )
                                        ],
                                        hint: "State",
                                        searchHint: "Select State",
                                        onChanged: (value) {
                                          registrationData.state = value;
                                          print(registrationData.state);
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: SearchableDropdown.single(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        clearIcon: Icon(
                                          Icons.cancel,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Jalandhar'),
                                            value: 'jalandhar',
                                          )
                                        ],
                                        hint: "City",
                                        searchHint: "Select City",
                                        onChanged: (value) {
                                          registrationData.city = value;
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SearchableDropdown.single(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        clearIcon: Icon(
                                          Icons.cancel,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Jalandhar'),
                                            value: 'jalandhar',
                                          )
                                        ],
                                        hint: "District",
                                        searchHint: "Select District",
                                        onChanged: (value) {
                                          registrationData.district = value;
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: SearchableDropdown.single(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        clearIcon: Icon(
                                          Icons.cancel,
                                          size: 20,
                                          color: Colors.green.shade900,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('Kahlon'),
                                            value: 'kahlon',
                                          )
                                        ],
                                        hint: "Village",
                                        searchHint: "Select Village",
                                        onChanged: (value) {
                                          registrationData.village = value;
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomButton(
                          color: Colors.green.shade900,
                          onPress: () {
                            if (registrationData.name == null ||
                                registrationData.phoneNumber == null ||
                                registrationData.adhaarNumber == null ||
                                registrationData.password == null ||
                                registrationData.city == null ||
                                registrationData.district == null ||
                                registrationData.state == null ||
                                registrationData.village == null ||
                                registrationData.numberOfFields == null) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: 'Please enter all fields !!',
                                  confirmBtnColor: Colors.green.shade900);
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return KhasraNumberInputSheet();
                                  });
                            }
                          },
                          text: 'Proceed',
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
