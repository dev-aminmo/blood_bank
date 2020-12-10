import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double height;
  double width;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailEditingController;
  TextEditingController _passEditingController;

  @override
  void initState() {
    _emailEditingController = TextEditingController();
    _passEditingController = TextEditingController();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Text(
              'Login',
              style: SharedUI.textStyle(Colors.black).copyWith(fontSize: 28),
            ),
            Form(
                key: _formKey,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            /*SharedUI.input('Email Address'),*/
                            TextFormField(
                              controller: _emailEditingController,
                              style: SharedUI.textFormFieldStyle,
                              cursorColor: SharedUI.red,
                              decoration:
                              SharedUI.inputDecoration("Email Address"),
                              validator: (v) {
                                if (v.length < 5) {
                                  return "Hello ";
                                }
                                return null;
                              },
                              onChanged: (v) {
                                print('onchanged $v ');
                              },
                            ),
                            SizedBox(),
                            TextFormField(
                              controller: _passEditingController,
                              style: SharedUI.textFormFieldStyle,
                              obscureText: _obscureText,
                              cursorColor: SharedUI.red,
                              decoration: SharedUI.inputDecoration("Password",
                                  suffix: IconButton(
                                    icon: Icon(
                                      (_obscureText)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    color: SharedUI.gray,
                                  )),
                              validator: (v) {
                                if (v.length < 5) {
                                  return "Hello ";
                                }
                                return null;
                              },
                              onChanged: (v) {
                                print('onchanged $v ');
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            SharedUI.drawButton(width, height * 0.85, 'Log in',
                                event: () {
                                  print(_formKey.currentState.validate());
                                }),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
