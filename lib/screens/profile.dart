import 'dart:io';

import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _image;
  DateTime _dateTime = DateTime.now();
  double height;
  double width;

  Widget _myCustomCard(double height, double width, child) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: SharedUI.lightGray, offset: Offset(0, 0), blurRadius: 3)
          ]),
      child: child,
    );
  }

  static const _propertyTextStyle =
  TextStyle(fontSize: 18, color: SharedUI.lightGray);
  static const _infoTextStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SharedUI.white,
      appBar: AppBar(
        title: Text(
          "Blood Bank",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 28),
        ),
        backgroundColor: SharedUI.white,
        bottom: buildTabBar(),
      ),
      body: TabBarView(
        children: [buildProfile(), buildEditProfile(context), buildSecurity()],
        controller: _tabController,
      ),
    );
  }

  Container buildSecurity() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.07),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          SharedUI.input('Current Password'),
          SizedBox(
            height: height * 0.05,
          ),
          SharedUI.input('New Password'),
          SizedBox(
            height: height * 0.05,
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xff26FB81),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.check,
                      size: width * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'at least 8 characters',
                    style: TextStyle(
                        color: Color(0xff26FB81),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                children: [
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xff8FA0B3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.check,
                      size: width * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    'have a capital letter',
                    style: TextStyle(
                        color: Color(0xff8FA0B3),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildEditProfile(BuildContext context) {
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

  SingleChildScrollView buildProfile() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07),
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: width / 4,
              backgroundColor: SharedUI.lightGray,
            ),
            _myCustomCard(
                height,
                width,
                buildCardContent("Full name", "Meziane Khalil", "Email",
                    "Meziane@khalil.com")),
            _myCustomCard(
                height,
                width,
                buildCardContent(
                    "Address", "Chettia Chlef", "Phone number", "0556096798")),
            _myCustomCard(
                height,
                width,
                buildCardContent(
                    "Blood Type", "A+", "Birth date", "28/02/2000")),
          ],
        ),
      ),
    );
  }

  Column buildCardContent(
      String property1, String value1, String property2, String value2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$property1:",
              style: _propertyTextStyle,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "$value1",
              softWrap: true,
              style: _infoTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$property2:",
              style: _propertyTextStyle,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "$value2",
              softWrap: true,
              style: _infoTextStyle,
            ),
          ],
        ),
      ],
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
            initialDatePickerMode: DatePickerMode.year,
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

  TabBar buildTabBar() {
    return TabBar(
      labelColor: SharedUI.red,
      indicatorColor: SharedUI.red,
      unselectedLabelColor: SharedUI.lightGray,
      indicatorWeight: 3.5,
      tabs: [
        Tab(
          icon: Icon(Icons.person),
          text: 'Profile',
        ),
        Tab(
          icon: Icon(Icons.edit_rounded),
          text: 'Edit profile',
        ),
        Tab(
          icon: Icon(Icons.shield),
          child: Text("Security"),
        ),
      ],
      controller: _tabController,
    );
  }

  _imgFromGallery() async {
    var image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }
}
