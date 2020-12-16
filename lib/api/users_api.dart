import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
      if (response.statusCode == 401) {
        sharedPreferences.setString("token", null);
        return 401;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", null);
    return true;
  }

  Future<bool> updateInfo(Map<dynamic, dynamic> data) async {
    var _url = API.kBASE_URL + "profile/updateInfo";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    try {
      var response = await http.put(_url,
          headers: {HttpHeaders.authorizationHeader: token}, body: data);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
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

  Future<dynamic> updateProfileImage(var pickedFile) async {
    var _url = API.kBASE_URL + "profile/uploadProfileImage";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    try {
      var filename = pickedFile.path.split("/").last;
      final _storage = FirebaseStorage.instance;
      var file = File(pickedFile.path);
      var snapshot = await _storage
          .ref()
          .child('folderName/$filename')
          .putFile(file)
          .onComplete;

      var downloadUrl = await snapshot.ref.getDownloadURL();
      var response = await http.patch(_url, headers: {
        HttpHeaders.authorizationHeader: token
      }, body: {
        "path": downloadUrl,
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
