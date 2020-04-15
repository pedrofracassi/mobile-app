import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicorum_app/constants.dart';

class DeezerApi {
  Future<String> getArtistImage(String name) async {
    final String url = '$DEEZER_API_URL/search/artist?q=${Uri.encodeComponent(name)}';
    print('making request');
    Response response = await get(url);


    if (response.statusCode == 200) {
      print('RESPONSE');
      print(response.body);
      return jsonDecode(response.body)['data'][0]['picture_medium'];
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }
}