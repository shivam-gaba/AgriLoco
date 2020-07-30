import 'dart:convert';

import 'package:http/http.dart';

class NetworkingHelper {
  String url;

  NetworkingHelper({this.url});

  Future getData() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
