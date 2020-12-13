import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'api_endpoints.dart';

class UserApi {
  Future<List<User>> fetchUsers(String queryString) async {
    var query = (queryString != null) ? queryString : "";
    String _url = API.kBASE_URL + "search" + query;
    List<User> usersList = List<User>();
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["response"]["users"];
      for (var item in data) {
        usersList.add(User.fromJson(item));
      }
    }
    return usersList;
  }

  Future<dynamic> fetchUserInfo() async {
    var _url = API.kBASE_URL + "profile/info";
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http
          .get(_url, headers: {HttpHeaders.authorizationHeader: token});
      try {
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          var data = jsonData["userData"];
          return User.fromJson(data);
        }
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
