import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response =
        await http.get(_url, headers: {HttpHeaders.authorizationHeader: token});
    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var data = jsonData["userData"];
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateInfo(Map<dynamic, dynamic> data) async {
    var _url = API.kBASE_URL + "profile/updateInfo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.put(_url,
        headers: {HttpHeaders.authorizationHeader: token}, body: data);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePassword(String currentPass, String newPass) async {
    var _url = API.kBASE_URL + "profile/updatepassword";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.put(_url, headers: {
      HttpHeaders.authorizationHeader: token
    }, body: {
      "password": currentPass,
      "newPassword": newPass,
      "confirmNewPassword": newPass
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfileImage3(var pickedFile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    Dio dio = Dio();
    final File file = File(pickedFile.path);
    String fileName = file.path.split('/').last;
    dio.options.headers["authorization"] = token;
    FormData formData = FormData.fromMap({
      "profilePicture": await MultipartFile.fromFile(file.path),
    });
    try {
      var response = await dio
          .patch(API.kBASE_URL + "profile/uploadProfileImage", data: formData);
      print(file.path);
      print(response.statusCode);
      print(response);
      return true;
    } catch (r) {
      print(r.toString());
      return false;
    }
  }
}
