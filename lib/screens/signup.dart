import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
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
                SharedUI.drawButton(width, height * 0.9, 'Next')
              ],
            ),
          ),
        ));
  }
}
