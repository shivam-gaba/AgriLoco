import 'dart:async';
import 'dart:io';
import 'package:agri_loco/Components/CustomButton.dart';
import 'package:agri_loco/Models/WaterReportModel.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WaterReportsScreen extends StatefulWidget {
  final List<WaterReportModel> waterReportsList;
  WaterReportsScreen({this.waterReportsList});

  @override
  _WaterReportsScreenState createState() => _WaterReportsScreenState();
}

class _WaterReportsScreenState extends State<WaterReportsScreen> {
  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }
    return filePath;
  }

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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.white, width: 2),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Khasra Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Crop Type',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Village',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Field Size',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Average Water consumption',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('Water Source',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[0].khasraNumber,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[0].cropType,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[0].village,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[0].fieldSize,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('${widget.waterReportsList[0].fieldSize}0',
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[0].waterSource,
                            textAlign: TextAlign.center)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[1].khasraNumber,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[1].cropType,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[1].village,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[1].fieldSize,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('${widget.waterReportsList[1].fieldSize}0',
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[1].waterSource,
                            textAlign: TextAlign.center)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[2].khasraNumber,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[2].cropType,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[2].village,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[2].fieldSize,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('${widget.waterReportsList[2].fieldSize}0',
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[2].waterSource,
                            textAlign: TextAlign.center)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[3].khasraNumber,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[3].cropType,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[3].village,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[3].fieldSize,
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text('${widget.waterReportsList[3].fieldSize}0',
                            textAlign: TextAlign.center)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableCell(
                        child: Text(widget.waterReportsList[3].waterSource,
                            textAlign: TextAlign.center)),
                  ),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
              onPress: () {
                downloadFile(
                    'https://docs.google.com/spreadsheets/d/14CS-GjWis-RtVq35KLyzQ7OPj1um91Ha05bUb4PppMM/edit?usp=sharing',
                    'fileName',
                    'dir');
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.info,
                  confirmBtnColor: Colors.green.shade900,
                  title: 'download Successful !! ',
                );
              },
              text: "Export Data",
              color: Colors.green.shade900,
            ),
          )
        ],
      ),
    );
  }
}
