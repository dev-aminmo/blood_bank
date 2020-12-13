import 'dart:convert';

import 'package:blood_app/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpAPI {
  String baseUrl = API.kBASE_URL;

  Future<bool> emailExists(String email) async {
    print(email);
    var response =
        await http.post(baseUrl + "user/emailCheck", body: {"email": email});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<dynamic> signUpUser(Map<dynamic, dynamic> data) async {
    var response = await http.post(baseUrl + "user/signup", body: data);
    print(response.body);
    if (response.statusCode == 201) {
      try {
        var jsonData = jsonDecode(response.body);
        var token = jsonData["token"];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        print(token);
        return true;
      } catch (excpetion) {
        print(excpetion);
        return false;
      }
    }
    return false;
  }
}
