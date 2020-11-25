import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _tabController;
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
        bottom: TabBar(
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
        ),
      ),
      body: TabBarView(
        children: [
          SingleChildScrollView(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fullname:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "Meziane Khalil",
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
                                "Email:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "Meziane@Khalil.com",
                                softWrap: true,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )),
                  _myCustomCard(
                      height,
                      width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "Chettia Chlef",
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
                                "EmailPhone number:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "0556096798",
                                softWrap: true,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )),
                  _myCustomCard(
                      height,
                      width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Blood Type:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "A+",
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
                                "Birth date:",
                                style: _propertyTextStyle,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "28/02/2000",
                                softWrap: true,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
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
                  /*FlatButton(
                    onPressed: () {},
                    child: Text("Pick an image"),
                    color: Colors.red,
                  ),*/
                  SharedUI.drawButton(
                      width / 1.5, height / 1.5, "Pick an image"),
                  SharedUI.profileInput("Full Name"),
                  SharedUI.profileInput("Phone Number"),
                  DropdownButton<String>(
                    itemHeight: height * 0.12,
                    isExpanded: true,
                    hint: Text(
                      "Blood Type",
                      style: SharedUI.textStyle(SharedUI.gray)
                          .copyWith(fontSize: 22),
                    ),
                    value: "A+",
                    icon: Icon(
                      Icons.expand_more,
                      color: SharedUI.red,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style:
                        SharedUI.textStyle(Colors.black).copyWith(fontSize: 20),
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
                  ),
                  SizedBox(
                    width: width * 0.85,
                    height: height * 0.1,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.5, color: Color(0xffCBD5E0)),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        '26/02/2000',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: SharedUI.red,
                            fontSize: 22),
                      ),
                      color: SharedUI.white,
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(1920),
                          lastDate: DateTime(2020, 12, 31),
                          initialDatePickerMode: DatePickerMode.year,
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: SharedUI.red,
                                accentColor: SharedUI.red,
                                colorScheme:
                                    ColorScheme.light(primary: SharedUI.red),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
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
                  ),
                ],
              ),
            ),
          ),
          Container(
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
          )
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }
}
