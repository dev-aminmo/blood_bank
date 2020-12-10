import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'api_endpoints.dart';

class UserApi {
  Future<List<User>> fetchUsers(String queryString) async {
    var query = (queryString != null) ? queryString : "";
    String _allUsers = API.kBASE_URL + "search" + query;
    List<User> usersList = List<User>();
    var response = await http.get(_allUsers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["users"];
      for (var item in data) {
        usersList.add(User.fromJson(item));
      }
    }

    return usersList;
  }
}
