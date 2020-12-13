import 'dart:convert';

import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

class MyThirdForm extends StatefulWidget {
  MyThirdForm(this.height, this.width, this.goNext, {Key key})
      : super(key: key);

  double width;
  double height;
  Function goNext;

  @override
  _MyThirdFormState createState() => _MyThirdFormState();
}

class _MyThirdFormState extends State<MyThirdForm> {
  String bloodDropDownValue;
  String stateDropDownValue;
  String municipalDropDownValue;
  String stateId;
  String municipal;
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
      child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/wilayas.json'),
          builder: (ctx, snapShotDropDown) {
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

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            DropdownButton<String>(
                              itemHeight: widget.height * 0.12,
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
                              style: SharedUI.textStyle(Colors.black)
                                  .copyWith(fontSize: 20),
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
                            (bloodDropDownValue == null && valid == true)
                                ? Text(
                                    "please select your blood type",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: SharedUI.red,
                                        fontSize: 14),
                                  )
                                : SizedBox()
                          ],
                        ),
                        Column(
                          children: [
                            DropdownButton<String>(
                              itemHeight: widget.height * 0.12,
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
                              items: states.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            (stateDropDownValue == null && valid == true)
                                ? Text(
                                    "please select your state",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: SharedUI.red,
                                        fontSize: 14),
                                  )
                                : SizedBox()
                          ],
                        ),
                        Column(
                          children: [
                            DropdownButton<String>(
                              itemHeight: widget.height * 0.12,
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
                              items: municipales.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            (municipalDropDownValue == null && valid == true)
                                ? Text(
                                    "please select your municipal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: SharedUI.red,
                                        fontSize: 14),
                                  )
                                : SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: widget.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                  SharedUI.drawButton(widget.width, widget.height, 'Next',
                      event: () {
                    setState(() {
                      valid = true;
                    });
                    if (bloodDropDownValue != null &&
                        stateDropDownValue != null &&
                        municipalDropDownValue != null) {
                      widget.goNext(data: {
                        'bloodType': bloodDropDownValue,
                        'state': stateDropDownValue,
                        'municipal': municipalDropDownValue,
                      });
                    }
                  })
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
