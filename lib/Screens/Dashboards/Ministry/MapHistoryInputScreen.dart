import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Screens/Dashboards/Ministry/MinistryMapScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class MapHistoryInputSheet extends StatefulWidget {
  @override
  _MapHistoryInputSheetState createState() => _MapHistoryInputSheetState();
}

class _MapHistoryInputSheetState extends State<MapHistoryInputSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        leading: Icon(Icons.filter_hdr),
        backgroundColor: Colors.green.shade900,
        title: Text('AGRI LOCO',
            style: GoogleFonts.indieFlower(
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: ListView(
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
                  child: Text('2020'),
                  value: '2020',
                ),
              ],
              hint: "Select Year",
              searchHint: "Select Year",
              onChanged: (value) {
                setState(() {});
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
              items: [
                DropdownMenuItem(
                  child: Text('Rabi'),
                  value: 'rabi',
                ),
                DropdownMenuItem(
                  child: Text('Zaid'),
                  value: 'zaid',
                ),
                DropdownMenuItem(
                  child: Text('Kharif'),
                  value: 'kharif',
                ),
              ],
              hint: "Select Season",
              searchHint: "Select Season",
              onChanged: (value) {
                setState(() {});
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
              items: [
                DropdownMenuItem(
                  child: Text('Punjab'),
                  value: 'punjab',
                ),
                DropdownMenuItem(
                  child: Text('Haryana'),
                  value: 'haryana',
                ),
                DropdownMenuItem(
                  child: Text('Himachal'),
                  value: 'himachal',
                ),
              ],
              hint: "Select State",
              searchHint: "Select State",
              onChanged: (value) {
                setState(() {});
              },
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: CustomButton(
              color: Colors.green.shade900,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MinistryMapScreen()));
              },
              text: 'Show Map History',
            ),
          )
        ],
      ),
    );
  }
}
