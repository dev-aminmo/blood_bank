import 'dart:io';

import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  double height;

  double width;

  var _image;

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
                  : NetworkImage("https://source.unsplash.com/random"),

              /*child: ClipOval(
                child: (_image != null)
                    ? Image.file(File(_image.path))
                    : Image.network("https://source.unsplash.com/random",
                        width: width, height: width, fit: BoxFit.cover),
              ),*/
              backgroundColor: SharedUI.lightGray,
            ),
            SharedUI.drawButton(width / 1.5, height / 1.5, "Pick an image",
                event: () {
              _imgFromGallery();
            }),
            SharedUI.profileInput("Full Name"),
            SharedUI.profileInput("Phone Number"),
            buildDropdownButton(),
            buildDatePicker(context),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      itemHeight: height * 0.12,
      isExpanded: true,
      hint: Text(
        "Blood Type",
        style: SharedUI.textStyle(SharedUI.gray).copyWith(fontSize: 22),
      ),
      value: "A+",
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
          var bloodDropDownValue = newValue;
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
      height: height * 0.1,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: Color(0xffCBD5E0)),
            borderRadius: BorderRadius.circular(40)),
        child: Text(
          '26/02/2000',
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
