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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
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
                  style:
                      SharedUI.textStyle(Colors.black).copyWith(fontSize: 20),
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
                  style:
                      SharedUI.textStyle(Colors.black).copyWith(fontSize: 20),
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
                SizedBox(
                  height: widget.height * 0.05,
                ),
              ],
            ),
          ),
          SharedUI.drawButton(widget.width, widget.height, 'Next',
              event: widget.goNext)
        ],
      ),
    );
  }
}
