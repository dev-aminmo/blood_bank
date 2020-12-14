import 'package:flutter/foundation.dart';

class User {
  String profileImage;
  String id;
  String fullName;
  String bloodType;
  String phoneNumber;
  String state;
  String municipal;
  String birthDay;
  String birthMonth;
  String birthYear;
  String email;

  User(
      {this.profileImage,
      @required this.id,
      @required this.fullName,
      @required this.bloodType,
      @required this.phoneNumber,
      @required this.state,
      @required this.municipal,
      @required this.birthDay,
      @required this.birthMonth,
      @required this.birthYear,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    this.profileImage = json['profileImage'];
    this.id = json['_id'];
    this.fullName = json['fullName'];
    this.bloodType = json['bloodType'];
    this.phoneNumber = json['phoneNumber'];
    this.state = json['state'];
    this.municipal = json['municipal'];
    this.birthDay = json['birthDat'];
    this.birthMonth = json['birthMonth'];
    this.birthYear = json['birthYear'];
    this.email = json['email'];
  }
}
