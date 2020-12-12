import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blood_app/api/auth/signup.dart';
import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/material.dart';

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
  TextEditingController _fullNameEditingController;
  TextEditingController _emailEditingController;
  TextEditingController _passEditingController;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passFormKey = GlobalKey<FormFieldState>();
  bool _obscureText = true;
  bool _isLoading = false;
  FocusNode _passwordFocusNode = FocusNode();
  bool _passHasFocus = false;
  bool _passHave6chars = false;
  bool _passHaveCapitalLetter = false;

  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return Container(
      height: height * 0.8,
      child: IgnorePointer(
        ignoring: _isLoading,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: !_passHasFocus
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              _passHasFocus
                  ? SizedBox(
                      height: height * 0.07,
                    )
                  : SizedBox(),
              Visibility(
                visible: !_passHasFocus,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _fullNameEditingController,
                  style: SharedUI.textFormFieldStyle,
                  cursorColor: SharedUI.red,
                  decoration: SharedUI.inputDecoration("Full name"),
                  validator: (v) {
                    if (v.length < 1) {
                      return "please enter your full name";
                    }
                    return null;
                  },
                ),
              ),
              Visibility(
                visible: !_passHasFocus,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailEditingController,
                  style: SharedUI.textFormFieldStyle,
                  cursorColor: SharedUI.red,
                  decoration: SharedUI.inputDecoration("Email Address"),
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
              ),
              TextFormField(
                key: _passFormKey,
                focusNode: _passwordFocusNode,
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
                  ? SizedBox(
                      height: height * 0.05,
                    )
                  : SizedBox(),
              _passHasFocus
                  ? Column(
                      children: [
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
                height: height * 0.05,
              ),
              Visibility(
                visible: !_passHasFocus,
                child: Builder(
                  builder: (context) => SharedUI.drawButton(
                      width, height * 0.9, 'Next', event: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: SharedUI.lightGray,
                        content: Container(
                          height: height * 0.04,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Checking if email exists ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    textBaseline: TextBaseline.alphabetic),
                              ),
                              TyperAnimatedTextKit(
                                text: ['...'],
                                speed: Duration(milliseconds: 100),
                                textStyle: TextStyle(
                                    fontSize: 30.0, color: SharedUI.white),
                              ),
                            ],
                          ),
                        ),
                      ));
                      setState(() {
                        _isLoading = true;
                      });
                      var b = await SignUpAPI().emailExists(
                          _emailEditingController.value.text.trim());
                      setState(() {
                        _isLoading = false;
                      });
                      Scaffold.of(context).hideCurrentSnackBar();
                      if (!b) {
                        widget.goNext();
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.only(left: width * 0.1),
                          content: Container(
                            height: height * 0.04,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                ),
                                const Text(
                                  "  email exists before",
                                  style: TextStyle(
                                      color: SharedUI.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: SharedUI.red,
                        ));
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

  @override
  void initState() {
    super.initState();
    _fullNameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passEditingController = TextEditingController();
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
  void dispose() {
    _fullNameEditingController.dispose();
    _passEditingController.dispose();
    _emailEditingController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
