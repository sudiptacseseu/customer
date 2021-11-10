import 'dart:convert';

import 'package:customer/models/user_info.dart';
import 'package:http/http.dart';

class NetworkCall {
  var baseUrl = "https://api.jsonbin.io";
  var endPoint = "/b/5f1583d1c1edc466175a9bb6";
  var secretKeyValue =
      "\$2b\$10\$fFqNPA2vgz2sQ0mmxOrOHe2.II7fj0fxcVtK5m0eZ0QkELXLWmlCW";

  Future<UserInfo> getAllUsers() async {
    Map<String, String> secretKey;
    secretKey = {
      'secret-key': secretKeyValue,
    };
    var finalUrl = baseUrl + endPoint;
    final response = await get(Uri.parse(finalUrl), headers: secretKey);
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      print("Users data: ${response.body}");
      return UserInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting Users!");
    }
  }
}
