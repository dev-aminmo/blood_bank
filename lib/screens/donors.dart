import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Donors extends StatefulWidget {
  @override
  _DonorsState createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  double height;
  double width;
  String stateDropDownValue;

  // final AsyncMemoizer _memoizer = AsyncMemoizer();
  String municipalDropDownValue;
  String bloodDropDownValue;
  static const _propertyTextStyle =
      TextStyle(fontSize: 18, color: SharedUI.lightGray);
  static const _infoTextStyle = TextStyle(fontSize: 18);
  var avatars;

  @override
  void initState() {
    avatars = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          itemHeight: height * 0.1,
                          isExpanded: true,
                          hint: Text(
                            "State",
                            style: SharedUI.textStyle(SharedUI.gray)
                                .copyWith(fontSize: 22),
                          ),
                          value: stateDropDownValue,
                          icon: Icon(
                            Icons.expand_more,
                            color: SharedUI.red,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: SharedUI.textStyle(Colors.black)
                              .copyWith(fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: SharedUI.red,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              stateDropDownValue = newValue;
                            });
                          },
                          items: <String>[
                            'One',
                            'Two',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          itemHeight: height * 0.1,
                          isExpanded: true,
                          hint: Text(
                            "Municipal",
                            style: SharedUI.textStyle(SharedUI.gray)
                                .copyWith(fontSize: 22),
                          ),
                          value: municipalDropDownValue,
                          icon: Icon(
                            Icons.expand_more,
                            color: SharedUI.red,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: SharedUI.textStyle(Colors.black)
                              .copyWith(fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: SharedUI.red,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              municipalDropDownValue = newValue;
                            });
                          },
                          items: <String>[
                            'One',
                            'Two',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  DropdownButton<String>(
                    itemHeight: height * 0.1,
                    isExpanded: true,
                    hint: Text(
                      "Blood Type",
                      style: SharedUI.textStyle(SharedUI.gray)
                          .copyWith(fontSize: 22),
                    ),
                    value: bloodDropDownValue,
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
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SharedUI.drawButton(
                    width / 2,
                    height / 1.3,
                    'Search',
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              );
            }
            return Card(
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
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
                                // ignore: missing_return
                                builder: (ctx, snapshot) {
                                  Widget child;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      child = Container(
                                        width: width * 0.2,
                                        height: width * 0.2,
                                        child: Center(
                                          child: Container(
                                            width: width * 0.1,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      );
                                      continue display;
                                    case ConnectionState.done:
                                      if (snapshot.hasError) {
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
                                              snapshot.data.bodyBytes));
                                      avatars[index] = child;
                                      continue display;
                                    display:
                                    default:
                                      return AnimatedSwitcher(
                                        duration: Duration(milliseconds: 300),
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
                            "Meziane Khalil",
                            softWrap: true,
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
                          "A+",
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
                          "0698989098",
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
                          "Chettia Chlef",
                          style: _infoTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
