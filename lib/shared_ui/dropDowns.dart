import 'dart:convert';

import 'package:flutter/material.dart';

import 'sharedui.dart';

class DropDowns extends StatefulWidget {
  final Function search;

  DropDowns({@required this.search});

  @override
  _DropDownsState createState() => _DropDownsState();
}

class _DropDownsState extends State<DropDowns> {
  String stateDropDownValue;
  String municipalDropDownValue;
  String bloodTypeDropDownValue;
  String stateId;
  String municipal;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/wilayas.json'),
        builder: (ctxDropDown, snapShotDropDown) {
          if (snapShotDropDown.connectionState == ConnectionState.done) {
            var data = json.decode(snapShotDropDown.data);
            List<String> municipales = [];
            List<String> states = [];
            for (var i = 1; i <= data[0].length; i++) {
              states.add(data[0][i.toString()]["name"]);
            }
            if (stateDropDownValue != null) {
              for (var i = 1; i <= data[0].length; i++) {
                if (data[0][i.toString()]["name"] == stateDropDownValue) {
                  stateId = i.toString();
                }
              }
              data[0][stateId]["communes"].forEach((k, v) =>
                  municipales.add(data[0][stateId]["communes"][k]["name"]));
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
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
                              municipalDropDownValue = null;
                              stateDropDownValue = newValue;
                            });
                          },
                          items: states
                              .map<DropdownMenuItem<String>>((String value) {
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
                          items: municipales
                              .map<DropdownMenuItem<String>>((String value) {
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
                    value: bloodTypeDropDownValue,
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
                        bloodTypeDropDownValue = newValue;
                      });
                    },
                    items: [
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
                  SharedUI.drawButton(width / 2, height / 1.3, 'Search',
                      event: () {
                    widget.search(stateDropDownValue, municipalDropDownValue,
                        bloodTypeDropDownValue);
                  }),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        });
  }
}
