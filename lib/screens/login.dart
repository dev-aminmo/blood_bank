import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1),
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Text(
              'Login',
              style: SharedUI.textStyle(Colors.black).copyWith(fontSize: 28),
            ),
            Form(
                child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SharedUI.input('Email Address'),
                        SharedUI.input('Password'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SharedUI.drawButton(width, height * 0.85, 'Log in'),
                        Text(
                          'OR',
                          style: SharedUI.textStyle(SharedUI.red),
                        ),
                        SizedBox(
                          width: width * 0.85,
                          height: height * 0.1,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.5, color: Color(0xffCBD5E0)),
                                borderRadius: BorderRadius.circular(40)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/google_icon.svg',
                                  width: 25,
                                  height: 25,
                                ),
                                Text(
                                  'Log in with google',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: SharedUI.red,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                            color: SharedUI.white,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
