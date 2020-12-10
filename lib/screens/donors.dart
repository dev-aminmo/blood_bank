import 'package:blood_app/models/user.dart';
import 'package:blood_app/shared_ui/dropDowns.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var avatars;

  @override
  void initState() {
    super.initState();
    avatars = {};
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
          future: UserApi().fetchUsers(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data as List<User>;

              return ListView.builder(
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return DropDowns(
                      search:
                          (String state, String municipal, String bloodType) {
                        var q;
                        if (state != null) {
                          if (municipal == null) {
                            q = "?state=$state";
                          } else {
                            q = "?state=$state?municipal=$municipal";
                          }
                        }
                        if (bloodType != null) {
                          if (q == null) {
                            q = "?bloodType=$bloodType";
                          } else {
                            q = q + "?bloodType=$bloodType";
                          }
                        }
                        if (q != null) {
                          setState(() {
                            print(q);
                            query = "?state=chlef";
                          });
                        }
                      },
                    );
                  }

                  return Card(
                    margin: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.07),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              avatars.containsKey(index)
                                  ? avatars[index]
                                  : FutureBuilder(
                                      future: http.get(
                                          "https://source.unsplash.com/random?sig=$index?portrait"),
                                      // "http://10.0.2.2:3000${data[index - 1].profileImage}"),
                                      // ignore: missing_return
                                      builder: (ctx, imageSnapshot) {
                                        Widget child;
                                        switch (imageSnapshot.connectionState) {
                                          case ConnectionState.none:
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            child = Container(
                                              width: width * 0.2,
                                              height: width * 0.2,
                                              child: Center(
                                                child: Container(
                                                  width: width * 0.1,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            );
                                            continue display;
                                          case ConnectionState.done:
                                            if (imageSnapshot.hasError) {
                                              child = CircleAvatar(
                                                  radius: width * 0.1,
                                                  child: Text('Error'));
                                              avatars[index] = child;
                                              continue display;
                                            }
                                            // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                                            child = CircleAvatar(
                                                radius: width * 0.1,
                                                backgroundImage: MemoryImage(
                                                    imageSnapshot
                                                        .data.bodyBytes));
                                            avatars[index] = child;
                                            continue display;
                                          display:
                                          default:
                                            return AnimatedSwitcher(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: child,
                                            );
                                        }
                                      },
                                    ),
                              Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data[index - 1].fullName,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BloodType",
                                style: _propertyTextStyle,
                              ),
                              Text(
                                data[index - 1].bloodType,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.phone_rounded,
                                color: SharedUI.lightGray,
                              ),
                              Text(
                                data[index - 1].phoneNumber,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: SharedUI.lightGray,
                              ),
                              Text(
                                data[index - 1].municipal +
                                    " " +
                                    data[index - 1].state,
                                style: _infoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length + 1,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
