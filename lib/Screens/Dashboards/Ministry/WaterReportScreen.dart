import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Utilities/Constants.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class WaterReportScreen extends StatefulWidget {
  @override
  _WaterReportScreenState createState() => _WaterReportScreenState();
}

List<DropdownMenuItem> _cropsList = [];

class _WaterReportScreenState extends State<WaterReportScreen> {
  String region;
  String regionName;
  String waterSource;
  String cropType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < crops.length; i++) {
      _cropsList.add(DropdownMenuItem(
        child: Text(crops[i]),
        value: crops[i],
      ));
    }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        CustomButton(
          color: Colors.green.shade900,
          text: 'View Data',
          onPress: () {},
        )
      ],
    );
  }
}
