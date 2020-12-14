import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MySecondForm extends StatefulWidget {
  @override
  _MySecondFormState createState() => _MySecondFormState();

  double height;
  double width;
  Function goNext;

  MySecondForm(this.height, this.width, this.goNext, {Key key})
      : super(key: key);
}

class _MySecondFormState extends State<MySecondForm> {
  final GlobalKey<FormFieldState> _phoneFormKey = GlobalKey<FormFieldState>();

  final DateFormat formatter = DateFormat('yyyy\\MM\\dd');
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return Container(
      height: height * 0.8,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: width * 0.85,
                        height: height * 0.1,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.5, color: Color(0xffCBD5E0)),
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            _dateTime == null
                                ? 'Pick your birth date'
                                : formatter.format(_dateTime),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: SharedUI.red,
                                fontSize: 22),
                          ),
                          color: SharedUI.white,
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _dateTime == null
                                  ? DateTime(2005, 12, 31)
                                  : _dateTime,
                              firstDate: DateTime(1920),
                              lastDate: DateTime(2010, 12, 31),
                              initialEntryMode: DatePickerEntryMode.input,
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: SharedUI.red,
                                    accentColor: SharedUI.red,
                                    colorScheme: ColorScheme.light(
                                        primary: SharedUI.red),
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
                      SizedBox(
                        height: height * 0.01,
                      ),
                      (_dateTime == null &&
                              _phoneFormKey.currentState?.isValid == true)
                          ? Text(
                              "please enter your birthdate",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: SharedUI.red,
                                  fontSize: 14),
                            )
                          : SizedBox()
                    ],
                  ),
                  TextFormField(
                    key: _phoneFormKey,
                    keyboardType: TextInputType.number,
                    //   controller: _fullNameEditingController,
                    style: SharedUI.textFormFieldStyle,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    maxLength: 10,
                    cursorColor: SharedUI.red,
                    decoration: SharedUI.inputDecoration("Phone number"),
                    validator: (v) {
                      if (v.length < 1) {
                        return "please enter your phone number";
                      } else if (v.length < 10) {
                        return "please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SharedUI.drawButton(width, height * 0.9, 'Next', event: () {
                    if (_phoneFormKey.currentState.validate() &&
                        _dateTime != null) {
                      widget.goNext(data: {
                        'phoneNumber': _phoneFormKey.currentState.value,
                        'birthYear': _dateTime.year.toString(),
                        'birthMonth': _dateTime.month.toString(),
                        'birthDat': _dateTime.day.toString(),
                      });
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
