import 'package:blood_app/screens/profile.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/auth/login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double height;
  double width;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isloading = false;
  TextEditingController _emailEditingController;
  TextEditingController _passEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _passEditingController.dispose();
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: _isloading,
            child: Container(
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
                    style:
                        SharedUI.textStyle(Colors.black).copyWith(fontSize: 32),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailEditingController,
                                    style: SharedUI.textFormFieldStyle,
                                    cursorColor: SharedUI.red,
                                    decoration: SharedUI.inputDecoration(
                                        "Email Address"),
                                    validator: (v) {
                                      if (v.length < 1) {
                                        return "please enter an email address";
                                      }
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(v);
                                      if (!emailValid) {
                                        return "please enter a valid email";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(),
                                  TextFormField(
                                    controller: _passEditingController,
                                    style: SharedUI.textFormFieldStyle,
                                    obscureText: _obscureText,
                                    cursorColor: SharedUI.red,
                                    decoration:
                                        SharedUI.inputDecoration("Password",
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
                                      if (v.length < 1) {
                                        return "please enter a password";
                                      } else if (v.length < 6) {
                                        return "password is too short";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Center(
                                    child: Builder(
                                      builder: (context) => SharedUI.drawButton(
                                          width, height * 0.85, 'Log in',
                                          event: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          setState(() {
                                            _isloading = true;
                                          });

                                          var b = await LoginAPI().loginUser(
                                              _emailEditingController.value.text
                                                  .trim(),
                                              _passEditingController
                                                  .value.text);
                                          setState(() {
                                            _isloading = false;
                                          });

                                          if (b) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) => Profile()));
                                          } else {
                                            Scaffold.of(context).showSnackBar(
                                                SharedUI.failedSnackBar(
                                                    "Email or password invalid",
                                                    height));
                                          }
                                        }
                                      }),
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
                      )),
                ],
              ),
            ),
          ),
          _isloading
              ? Container(
                  color: Colors.black12,
                  child: Center(
                      child: CircularProgressIndicator(
                    // backgroundColor: Colors.red,
                    valueColor: AlwaysStoppedAnimation<Color>(SharedUI.red),
                  )),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
