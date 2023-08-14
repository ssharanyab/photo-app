import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_app/models/photo_data.dart';

import '../constants.dart';

class DataRepository {
  Future<PhotosData?> fetchData(String search) async {
    var headers = {'Authorization': APIKEY};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$search&per_page=50'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var getResponse = await response.stream.bytesToString();
      var decoded = jsonDecode(getResponse);
      PhotosData photosData = PhotosData.fromJson(decoded);

      return photosData;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
