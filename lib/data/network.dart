import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  late final String url;
  late final String url2; //미세먼지
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String jsonData = response.body;
      //jsonDecode에 타입은 dynamic이므로 var타입으로 작성 해야 함
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));

    if (response.statusCode == 200) {
      String jsonData = response.body;
      //jsonDecode에 타입은 dynamic이므로 var타입으로 작성 해야 함
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
