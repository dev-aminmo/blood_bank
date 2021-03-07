import 'dart:io';

import 'package:blood_app/api/users_api.dart';
import 'package:blood_app/models/user.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
  User user;
  Function updateCallback;

  EditProfile(this.user, {this.updateCallback});
}

class _EditProfileState extends State<EditProfile> {
  double height;
  double width;
  var _image;
  TextEditingController _fullNameEditingController;
  TextEditingController _phoneEditingController;
  final GlobalKey<FormFieldState> _phoneFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var bloodDropDownValue;
  var birthDate;

  @override
  void initState() {
    _fullNameEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _fullNameEditingController.value = TextEditingValue(
      text: widget.user.fullName,
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.user.fullName.length),
      ),
    );
    _phoneEditingController.value = TextEditingValue(
      text: widget.user.phoneNumber,
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.user.phoneNumber.length),
      ),
    );
    bloodDropDownValue = widget.user.bloodType;
    birthDate = DateTime(
      int.parse(widget.user.birthYear),
      int.parse(widget.user.birthMonth),
      int.parse(widget.user.birthDay),
    );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            CircleAvatar(
              radius: width / 4,
              backgroundImage: (_image != null)
                  ? FileImage(File(_image.path))
                  : NetworkImage(user.profileImage),
              backgroundColor: SharedUI.lightGray,
              onBackgroundImageError: (vb, t) {
                print("err");
              },
            ),
            SizedBox(
              height: height * 0.05,
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
            SizedBox(
              height: height * 0.05,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameEditingController,
                    style: SharedUI.textFormFieldStyle,
                    cursorColor: SharedUI.red,
                    validator: (v) {
                      if (v.length < 1) {
                        return "please enter your full name";
                      }
                      return null;
                    },
                    decoration: SharedUI.profileInputDecoration("Full Name"),
                  ),
                  SizedBox(height: height * 0.05),
                  TextFormField(
                    key: _phoneFormKey,
                    keyboardType: TextInputType.number,
                    controller: _phoneEditingController,
                    style: SharedUI.textFormFieldStyle,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    maxLength: 10,
                    cursorColor: SharedUI.red,
                    decoration: SharedUI.profileInputDecoration("Phone number"),
                    validator: (v) {
                      if (v.length < 1) {
                        return "please enter your phone number";
                      } else if (v.length < 10) {
                        return "please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  buildDropdownButton(bloodDropDownValue),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  buildDatePicker(context),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SharedUI.drawButton(width, height * 0.7, 'Update Info',
                      event: () async {
                    if (_formKey.currentState.validate()) {
                      var data = {
                        'fullName': _fullNameEditingController.value.text,
                        'bloodType': bloodDropDownValue,
                        'phoneNumber': _phoneEditingController.value.text,
                        "state": widget.user.state,
                        "municipal": widget.user.municipal,
                        'birthDat': birthDate.day.toString(),
                        'birthMonth': birthDate.month.toString(),
                        'birthYear': birthDate.year.toString(),
                      };
                      Scaffold.of(context).showSnackBar(
                        SharedUI.updatingSnackBar("Updating info ", height),
                      );
                      var response = await UserApi().updateInfo(data);
                      if (response) {
                        widget.updateCallback();
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                            SharedUI.successSnackBar(
                                "info updated successfully", height));
                      } else {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                            SharedUI.failedSnackBar(
                                "Can't update info", height));
                      }
                    }
                  }),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.1,
            )
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton(String initialBloodType) {
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

  SizedBox buildDatePicker(BuildContext context) {
    return SizedBox(
      width: width * 0.85,
      height: height * 0.08,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: Color(0xffCBD5E0)),
            borderRadius: BorderRadius.circular(40)),
        child: Text(
          birthDate.day.toString() +
              '/' +
              birthDate.month.toString() +
              '/' +
              birthDate.year.toString(),
          style: TextStyle(
              fontWeight: FontWeight.w400, color: SharedUI.red, fontSize: 22),
        ),
        color: SharedUI.white,
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: birthDate,
            firstDate: DateTime(1920),
            lastDate: DateTime(2005, 12, 31),
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
              birthDate = date;
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

    Scaffold.of(context).showSnackBar(
        SharedUI.updatingSnackBar("Updating profile image", height));

    var response = await UserApi().updateProfileImage(image);
    if (response) {
      Scaffold.of(context).hideCurrentSnackBar();
      widget.updateCallback();
      Scaffold.of(context).showSnackBar(
        SharedUI.successSnackBar("profile image updated successfully", height),
      );
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context)
          .showSnackBar(SharedUI.failedSnackBar("Can't update image", height));
    }
  }
}
