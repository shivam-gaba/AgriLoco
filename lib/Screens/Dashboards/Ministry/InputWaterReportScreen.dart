import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Components/CustomTextField.dart';
import 'package:agri_loco/Models/WaterReportModel.dart';
import 'package:agri_loco/Utilities/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'WaterReportsScreen.dart';

class InputWaterReportScreen extends StatefulWidget {
  @override
  _InputWaterReportScreenState createState() => _InputWaterReportScreenState();
}

List<DropdownMenuItem> _cropsList = [];
bool _isSpinnerShowing = false;
List<WaterReportModel> _waterReportsList = [];

class _InputWaterReportScreenState extends State<InputWaterReportScreen> {
  String region;
  String regionName;
  String waterSource;
  String cropType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _waterReportsList.clear();
    _cropsList.add(DropdownMenuItem(
      child: Text('All'),
      value: 'all',
    ));
    for (int i = 0; i < crops.length; i++) {
      _cropsList.add(DropdownMenuItem(
        child: Text(crops[i]),
        value: crops[i],
      ));
    }
  }

  void fetchData() async {
    _waterReportsList.clear();
    var _fireStore = Firestore.instance;

    await for (var snapshot
        in _fireStore.collection('FieldsData').snapshots()) {
      for (var khasraNumber in snapshot.documents) {
        _waterReportsList.add(
          WaterReportModel(
              khasraNumber: khasraNumber.documentID,
              fieldSize: khasraNumber.data['fieldSize'],
              cropType: khasraNumber.data['cropType'],
              village: khasraNumber.data['village'],
              waterSource: khasraNumber.data['waterSource']),
        );
      }
    }
  }

  void getData() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WaterReportsScreen(
                  waterReportsList: _waterReportsList,
                )));
  }

  DropdownMenuItem getRegionName() {
    switch (region) {
      case 'state':
        return DropdownMenuItem(
          child: Text('Punjab'),
          value: 'punjab',
        );

      case 'city':
        return DropdownMenuItem(
          child: Text('Jalandhar'),
          value: 'jalandhar',
        );

      case 'district':
        return DropdownMenuItem(
          child: Text('Jalandhar'),
          value: 'jalandhar',
        );

      case 'village':
        return DropdownMenuItem(
          child: Text('Kahlon'),
          value: 'kahlon',
        );

      default:
        return DropdownMenuItem(
          child: Text(''),
          value: '',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinnerShowing,
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                  child: Text('State'),
                  value: 'state',
                ),
                DropdownMenuItem(
                  child: Text('City'),
                  value: 'city',
                ),
                DropdownMenuItem(
                  child: Text('District'),
                  value: 'district',
                ),
                DropdownMenuItem(
                  child: Text('Village'),
                  value: 'village',
                )
              ],
              hint: "Select Region Level",
              searchHint: "Select State",
              onChanged: (value) {
                setState(() {
                  region = value;
                });
              },
              isExpanded: true,
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
              items: [getRegionName()],
              hint: "Select Region Name",
              searchHint: "Select State",
              onChanged: (value) {
                setState(() {
                  regionName = value;
                });
              },
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hint: 'Ground Water Level',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hint: 'Surface Water Level',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hint: 'Rain Water Level',
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: CustomRadioButton(
              buttonColor: Colors.white,
              height: 40,
              enableShape: true,
              buttonLables: ["Canal", "Ground", "Both"],
              buttonValues: ["canal", "ground", "both"],
              radioButtonValue: (value) {
                setState(() {
                  waterSource = value;
                });
              },
              selectedColor: Colors.green.shade900,
              padding: 0,
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
              items: _cropsList,
              hint: "Select Crop",
              searchHint: "Select Crop",
              onChanged: (value) {
                setState(() {
                  cropType = value;
                });
              },
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomButton(
                    color: Colors.green.shade900,
                    text: 'Fetch Data',
                    onPress: () {
                      if (waterSource == null ||
                          cropType == null ||
                          region == null ||
                          regionName == null) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            title: 'Please enter all fields !!',
                            confirmBtnColor: Colors.green.shade900);
                      } else {
                        fetchData();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    color: Colors.green.shade900,
                    text: 'View Data',
                    onPress: () {
                      if (_waterReportsList.isEmpty) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            title: 'Please Fetch Data Firstly !!',
                            confirmBtnColor: Colors.green.shade900);
                      } else {
                        getData();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
