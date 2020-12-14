import 'dart:io';

import 'package:blood_app/models/user.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api_endpoints.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  User user;

  EditProfile(this.user);
}

class _EditProfileState extends State<EditProfile> {
  double height;

  double width;

  var _image;
  DateTime _dateTime = DateTime.now();
  var name = "Moh";
  TextEditingController _fullNameEditingController;
  TextEditingController _phoneEditingController;

  @override
  void initState() {
    _fullNameEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07),
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //TODO try clipRRect with border Radius + child: ALign.center
            CircleAvatar(
              radius: width / 4,
              backgroundImage: (_image != null)
                  ? FileImage(File(_image.path))
                  : NetworkImage(API.kBASE_URL + user.profileImage),
              backgroundColor: SharedUI.lightGray,
            ),
            SizedBox(
              width: width * 0.65,
              height: height * 0.08,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Pick an image",
                    style: TextStyle(color: SharedUI.white, fontSize: 18),
                  ),
                  color: SharedUI.red,
                  onPressed: () {
                    _imgFromGallery();
                  }),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameEditingController,
                    //initialValue: name,
                    style: SharedUI.textFormFieldStyle,
                    cursorColor: SharedUI.red,
                    decoration: SharedUI.profileInputDecoration("Full Name"),
                  ),
                  TextFormField(
                    controller: _phoneEditingController,
                    // initialValue: user.phoneNumber,
                    style: SharedUI.textFormFieldStyle,
                    cursorColor: SharedUI.red,
                    decoration: SharedUI.profileInputDecoration("Phone Number"),
                  ),
                  buildDropdownButton(user.bloodType),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          //  name = "je picole mon";
                          //  _fullNameEditingController.text = "name";
                          final _newValue = "New value";
                          _fullNameEditingController.value = TextEditingValue(
                            text: _newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: _newValue.length),
                            ),
                          );
                        });
                      }),
                  Text(name),
                  buildDatePicker(context, user),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton(String initialBloodType) {
    var bloodDropDownValue;

    return DropdownButton<String>(
      itemHeight: height * 0.12,
      isExpanded: true,
      hint: Text(
        "Blood Type",
        style: SharedUI.textStyle(SharedUI.gray).copyWith(fontSize: 22),
      ),
      value: initialBloodType,
      icon: Icon(
        Icons.expand_more,
        color: SharedUI.red,
      ),
      iconSize: 24,
      elevation: 16,
      style: SharedUI.textStyle(Colors.black).copyWith(fontSize: 20),
      underline: Container(
        height: 2,
        color: SharedUI.red,
      ),
      onChanged: (String newValue) {
        setState(() {
          bloodDropDownValue = newValue;
        });
      },
      items: <String>[
        'A+',
        'A-',
        'B+',
        'B-',
        'AB+',
        'AB-',
        'O+',
        'O-',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  SizedBox buildDatePicker(BuildContext context, User user) {
    var initialDate = DateTime(
      int.parse(user.birthYear),
      int.parse(user.birthMonth),
      int.parse(user.birthDay),
    );
    return SizedBox(
      width: width * 0.85,
      height: height * 0.1,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: Color(0xffCBD5E0)),
            borderRadius: BorderRadius.circular(40)),
        child: Text(
          user.birthDay + '/' + user.birthMonth + '/' + user.birthYear,
          style: TextStyle(
              fontWeight: FontWeight.w400, color: SharedUI.red, fontSize: 22),
        ),
        color: SharedUI.white,
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            firstDate: DateTime(1920),
            lastDate: DateTime(2020, 12, 31),
            initialEntryMode: DatePickerEntryMode.input,
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: SharedUI.red,
                  accentColor: SharedUI.red,
                  colorScheme: ColorScheme.light(primary: SharedUI.red),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
          ).then((date) {
            setState(() {
              _dateTime = date;
            });
          });
        },
      ),
    );
  }

  _imgFromGallery() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }
}
