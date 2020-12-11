import 'dart:convert';

import 'package:blood_app/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  String baseUrl = API.kBASE_URL;

  Future<dynamic> loginUser(String email, String password) async {
    var response = await http.post(baseUrl + "user/login",
        body: {"email": email, "password": password});
    // body: {"email": "most@gmail.com", "password": "12345678"});
    print(response.body);

    if (response.statusCode == 200) {
      try {
        var jsonData = jsonDecode(response.body);
        var token = jsonData["token"];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        print(token);
        return true;
      } catch (Exception) {
        return false;
      }
    }
    return false;
  }
}
