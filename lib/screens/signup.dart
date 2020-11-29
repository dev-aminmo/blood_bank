import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'profile.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  static const Duration duration = Duration(milliseconds: 350);
  double height;
  double width;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: SharedUI.white,
        body: Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          backgroundColor: SharedUI.red,
                          child: AnimatedSwitcher(
                            duration: duration,
                            child: (_currentStep >= 1)
                                ? Icon(
                                    Icons.done,
                                    key: ValueKey<int>(_currentStep),
                                  )
                                : Text(
                                    "1",
                                    style: SharedUI.textStyle(SharedUI.white),
                                  ),
                          )),
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              height: 2,
                              color: SharedUI.gray,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: (_currentStep >= 1) ? width / 3 : 0,
                              height: 2,
                              color: SharedUI.red,
                            ),
                          ],
                        ),
                      ),
                      /*Flexible(
                        child: Container(
                          height: 2,
                          color: SharedUI.red,
                        ),
                      ),*/
                      CircleAvatar(
                          backgroundColor: (_currentStep >= 1)
                              ? SharedUI.red
                              : SharedUI.gray,
                          child: AnimatedSwitcher(
                            duration: duration,
                            child: (_currentStep >= 2)
                                ? Icon(
                                    Icons.done,
                                    key: ValueKey<int>(_currentStep),
                                  )
                                : Text(
                                    "2",
                                    style: SharedUI.textStyle(SharedUI.white),
                                  ),
                          )),
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              height: 2,
                              color: SharedUI.gray,
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: (_currentStep >= 2) ? width / 3 : 0,
                              height: 2,
                              color: SharedUI.red,
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            (_currentStep >= 2) ? SharedUI.red : SharedUI.gray,
                        child: Text(
                          "3",
                          style: SharedUI.textStyle(SharedUI.white),
                        ),
                      ),
                    ],
                  ),
                  AnimatedSwitcher(
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        final offsetAnimation = Tween<Offset>(
                            begin: Offset(5, 0), end: Offset(0, 0));
                        return FadeTransition(
                            child: SlideTransition(
                                child: child,
                                position: offsetAnimation.animate(animation)),
                            opacity: animation);
                      },
                      duration: Duration(milliseconds: 850),
                      switchInCurve: Curves.ease,
                      child: _getContent(
                          _currentStep, height * 0.9, width, goNext)),
                ],
              ),
            )));
  }

  _getContent(int currentStep, double height, double width, Function goNext) {
    switch (currentStep) {
      case 0:
        return MyFirstForm(
          height,
          width,
          goNext,
        );
        break;
      case 1:
        return MySecondForm(
          height,
          width,
          goNext,
        );
        break;
      case 2:
        return MyThirdForm(
          height,
          width,
          goNext,
        );
        break;
      default:
        return MyFirstForm(
          height,
          width,
          goNext,
        );
        break;
    }
  }

  goNext() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));
      }
    });
  }
}

class MyFirstForm extends StatefulWidget {
  double height;
  double width;
  Function goNext;

  MyFirstForm(this.height, this.width, this.goNext, {Key key})
      : super(key: key);

  @override
  _MyFirstFormState createState() => _MyFirstFormState();
}

class _MyFirstFormState extends State<MyFirstForm> {
  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return Container(
      height: height * 0.8,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SharedUI.input('Full name'),
            SharedUI.input('Email Address'),
            SharedUI.input('Password'),
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
                  height: height * 0.02,
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
            SharedUI.drawButton(width, height * 0.9, 'Next',
                event: widget.goNext)
          ],
        ),
      ),
    );
  }
}

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
  final DateFormat formatter = DateFormat('yyyy\\MM\\dd');
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    //MediaQuery.of(context).size.height;
    double width = widget.width;
    //MediaQuery.of(context).size.width;
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
                  SizedBox(
                    width: width * 0.85,
                    height: height * 0.1,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.5, color: Color(0xffCBD5E0)),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        _dateTime == null
                            ? 'Pick your birth date'
                            : formatter.format(_dateTime),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
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
                  SharedUI.input('Phone number'),
                  SharedUI.drawButton(width, height * 0.9, 'Next',
                      event: widget.goNext)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
