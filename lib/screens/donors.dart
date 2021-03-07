import 'package:blood_app/models/user.dart';
import 'package:blood_app/shared_ui/dropDowns.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

import '../api/users_api.dart';

class Donors extends StatefulWidget {
  @override
  _DonorsState createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  double height;
  double width;
  String query;
  static const _propertyTextStyle =
      TextStyle(fontSize: 18, color: SharedUI.lightGray);
  static const _infoTextStyle = TextStyle(fontSize: 18);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          DropDowns(
            search: (String state, String municipal, String bloodType) {
              var tempQuery;
              if (state != null) {
                if (municipal == null) {
                  tempQuery = "?state=$state";
                } else {
                  tempQuery = "?state=$state&municipal=$municipal";
                }
              }
              if (bloodType != null) {
                bloodType = bloodType.replaceAll("+", "%2B");
                if (tempQuery == null) {
                  tempQuery = "?bloodType=$bloodType";
                } else {
                  tempQuery = tempQuery + "&bloodType=$bloodType";
                }
              }
              if (tempQuery != null) {
                setState(() {
                  print(tempQuery);
                  //query = "?state=Tipaza";
                  query = tempQuery;
                });
              }
            },
          ),
          FutureBuilder(
              future: UserApi().fetchUsers(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data as List<User>;
                  /**
                   * case that there is no data is found display a message**/
                  if (data == null) {
                    return Align(
                      alignment: Alignment(0, -0.5),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                        color: Color(0Xffefb003),
                        height: height * 0.2,
                        width: width,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Icon(
                              Icons.warning,
                              color: SharedUI.white,
                              size: 36,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Center(
                              child: Text(
                                "Sorry there are no donors",
                                style: TextStyle(
                                    color: SharedUI.white, fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  /**
                   * case that there is no donors is found display a message**/
                  if (data.isEmpty) {
                    return Align(
                      alignment: Alignment(0, -0.5),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                        color: Color(0Xffefb003),
                        height: height * 0.2,
                        width: width,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Icon(
                              Icons.warning,
                              color: SharedUI.white,
                              size: 36,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Center(
                              child: Text(
                                "Sorry there are no donors",
                                style: TextStyle(
                                    color: SharedUI.white, fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  /**
                   * else display the list of the donors*/
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      print(data[index].profileImage);
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: height * 0.01, horizontal: width * 0.07),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data[index].profileImage),
                                    radius: width * 0.1,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      data[index].fullName,
                                      softWrap: true,
                                      textDirection: TextDirection.rtl,
                                      style: _infoTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BloodType",
                                    style: _propertyTextStyle,
                                  ),
                                  Text(
                                    data[index].bloodType,
                                    style: _infoTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    color: SharedUI.lightGray,
                                  ),
                                  Text(
                                    data[index].phoneNumber,
                                    style: _infoTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: SharedUI.lightGray,
                                  ),
                                  Text(
                                    data[index].municipal +
                                        " " +
                                        data[index].state,
                                    style: _infoTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      CircularProgressIndicator()
                    ],
                  ));
                }
              })
        ],
      ),
    );
  }
}
