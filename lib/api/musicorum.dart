import 'dart:convert';

import 'package:http/http.dart';
import 'package:musicorum_app/api/structures/user.dart';
import 'package:musicorum_app/constants.dart';

class MusicorumApi {
  Future<User> getCurrentAccount(String token) async {
    final String url = '$API_URL/auth/me';
    print('token: $token');
    final Map<String, String> headers = {"Authorization": token};
    print('making request');
    Response response = await get(url, headers: headers);


    if (response.statusCode == 200) {
      print('RESPONSE');
      print(response.body);
      return User.fromJSON(jsonDecode(response.body));
    } else {
      int code = response.statusCode;
      print('Error on API: Error code $code');
      throw Error();
    }
  }
}
