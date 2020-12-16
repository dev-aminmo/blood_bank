import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blood_app/api/users_api.dart';
import 'package:blood_app/models/user.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  double height;
  double width;
  TextEditingController _currentPasswordEditingController;
  TextEditingController _newPasswordEditingController;
  bool _currentObscureText = true;
  bool _newObscureText = true;
  static final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passFormKey = GlobalKey<FormFieldState>();
  bool _passHasFocus = false;
  bool _passHave6chars = false;
  bool _passHaveCapitalLetter = false;
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          _passHasFocus = true;
        });
      } else {
        setState(() {
          _passHasFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Visibility(
                visible: !_passHasFocus,
                child: TextFormField(
                  // key: _passFormKey,
                  controller: _currentPasswordEditingController,
                  style: SharedUI.textFormFieldStyle,
                  obscureText: _currentObscureText,
                  cursorColor: SharedUI.red,
                  decoration: SharedUI.inputDecoration('Current Password',
                      suffix: IconButton(
                        icon: Icon(
                          (_currentObscureText)
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentObscureText = !_currentObscureText;
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
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                key: _passFormKey,
                focusNode: _passwordFocusNode,
                controller: _newPasswordEditingController,
                style: SharedUI.textFormFieldStyle,
                obscureText: _newObscureText,
                cursorColor: SharedUI.red,
                decoration: SharedUI.inputDecoration("Password",
                    suffix: IconButton(
                      icon: Icon(
                        (_newObscureText)
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _newObscureText = !_newObscureText;
                        });
                      },
                      color: SharedUI.gray,
                    )),
                onChanged: (v) {
                  _checkPasswordContainsCapitalLetter(v);
                  setState(() {
                    _passFormKey.currentState.validate();
                  });
                },
                validator: (v) {
                  if (v.length < 1) {
                    return "please enter a password";
                  } else if (v.length < 6) {
                    setState(() {
                      _passHave6chars = false;
                    });
                    return "password is too short";
                  } else if (!_checkPasswordContainsCapitalLetter(v)) {
                    setState(() {
                      _passHave6chars = true;
                    });
                    return "password is weak";
                  }
                  setState(() {
                    _passHave6chars = true;
                  });

                  return null;
                },
              ),
              _passHasFocus
                  ? Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          children: [
                            Container(
                              height: width * 0.08,
                              width: width * 0.08,
                              decoration: BoxDecoration(
                                  color: _passHave6chars
                                      ? Color(0xff26FB81)
                                      : Color(0xff8FA0B3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Icon(
                                Icons.check,
                                size: width * 0.06,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Text(
                              'at least 6 characters',
                              style: TextStyle(
                                  color: _passHave6chars
                                      ? Color(0xff26FB81)
                                      : Color(0xff8FA0B3),
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
                              height: width * 0.08,
                              width: width * 0.08,
                              decoration: BoxDecoration(
                                  color: _passHaveCapitalLetter
                                      ? Color(0xff26FB81)
                                      : Color(0xff8FA0B3),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Icon(
                                Icons.check,
                                size: width * 0.06,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Text(
                              'have a capital letter',
                              style: TextStyle(
                                  color: _passHaveCapitalLetter
                                      ? Color(0xff26FB81)
                                      : Color(0xff8FA0B3),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: height * 0.1,
              ),
              Visibility(
                visible: !_passHasFocus,
                child: Builder(
                  builder: (context) => SharedUI.drawButton(
                      width, height * 0.9, 'Update password', event: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Scaffold.of(context).showSnackBar(
                          SharedUI.updatingSnackBar(
                              "Updating password ", height));
                      var response = await UserApi().updatePassword(
                          _currentPasswordEditingController.value.text,
                          _newPasswordEditingController.value.text);
                      if (response) {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                            SharedUI.successSnackBar(
                                "Password updated successfully", height));
                      } else {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                            SharedUI.failedSnackBar("Wrong password", height));
                      }
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkPasswordContainsCapitalLetter(String pass) {
    if (pass.toLowerCase() == pass) {
      setState(() {
        _passHaveCapitalLetter = false;
      });
      return false;
    }
    setState(() {
      _passHaveCapitalLetter = true;
    });
    return true;
  }
}
