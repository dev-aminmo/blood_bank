import 'package:blood_app/shared_ui/sharedui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/auth/signup.dart';
import 'profile.dart';
import 'signup_forms/first_form.dart';
import 'signup_forms/second_form.dart';
import 'signup_forms/third_form.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  static const Duration duration = Duration(milliseconds: 200);
  static const Duration steperDuration = Duration(milliseconds: 600);
  double height;
  double width;
  var _userData;
  int _currentStep = 0;
  bool canAnimateSecondContainer = false;
  bool canAnimateThirdContainer = false;
  AnimationController _firstRedAnimationController;
  AnimationController _firstGrayAnimationController;
  AnimationController _secondRedAnimationController;
  AnimationController _secondGrayAnimationController;
  Animation<int> _firstRedAnimation;
  Animation<int> _firstGrayAnimation;
  Animation<int> _secondRedAnimation;
  Animation<int> _secondGrayAnimation;

  @override
  void dispose() {
    _firstRedAnimationController.dispose();
    _firstGrayAnimationController.dispose();
    _secondRedAnimationController.dispose();
    _secondGrayAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _userData = {};
    _firstRedAnimationController = AnimationController(
      duration: steperDuration,
      vsync: this,
    )..addListener(() {
        setState(() {
          if (_firstRedAnimationController.isCompleted) {
            canAnimateSecondContainer = true;
          }
        });
      });
    _secondRedAnimationController = AnimationController(
      duration: steperDuration,
      vsync: this,
    )..addListener(() {
        setState(() {
          if (_secondRedAnimationController.isCompleted) {
            canAnimateThirdContainer = true;
          }
        });
      });
    _firstGrayAnimationController = AnimationController(
      duration: steperDuration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _secondGrayAnimationController = AnimationController(
      duration: steperDuration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _firstRedAnimation =
        IntTween(begin: 0, end: 10).animate(_firstRedAnimationController);
    _firstGrayAnimation =
        IntTween(begin: 10, end: 0).animate(_firstGrayAnimationController);
    _secondRedAnimation =
        IntTween(begin: 0, end: 10).animate(_secondRedAnimationController);
    _secondGrayAnimation =
        IntTween(begin: 10, end: 0).animate(_secondGrayAnimationController);

    super.initState();
  }

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
                    height: height * 0.13,
                  ),
                  MyCustomStepper(
                      duration: duration,
                      currentStep: _currentStep,
                      firstRedAnimation: _firstRedAnimation,
                      firstGrayAnimation: _firstGrayAnimation,
                      width: width,
                      canAnimateSecondContainer: canAnimateSecondContainer,
                      secondRedAnimation: _secondRedAnimation,
                      secondGrayAnimation: _secondGrayAnimation,
                      canAnimateThirdContainer: canAnimateThirdContainer),
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
                      child: _buildContent(
                          _currentStep, height * 0.9, width, goNext)),
                ],
              ),
            )));
  }

  _buildContent(int currentStep, double height, double width, Function goNext) {
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
      case 3:
        return Container(
          height: height * 0.8,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        return MyFirstForm(
          height,
          width,
          goNext,
        );
        break;
    }
  }

  goNext({Map<String, dynamic> data}) {
    data.forEach((k, v) => _userData[k] = v);
    print(_userData);
    setState(() {
      switch (_currentStep) {
        case 0:
          _currentStep++;
          _firstRedAnimationController.forward();
          _firstGrayAnimationController.forward();
          break;
        case 1:
          _currentStep++;
          _secondRedAnimationController.forward();
          _secondGrayAnimationController.forward();
          break;
        case 2:
          _singUpUser();
          break;
        default:
          _currentStep++;
          break;
      }
    });
  }

  void _singUpUser() async {
    setState(() {
      _currentStep++;
    });
    var response = await SignUpAPI().signUpUser(_userData);
    if (response) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    } else {
      setState(() {
        _currentStep = 0;
        _showError(context);
      });
    }
  }

  void _showError(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              backgroundColor: SharedUI.red,
              content: Container(
                height: height * 0.1,
                alignment: Alignment.centerLeft,
                child: Text(
                  "An error has occured",
                  style: TextStyle(
                      color: SharedUI.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 22),
                ),
              ));
        });
  }
}

class MyCustomStepper extends StatelessWidget {
  const MyCustomStepper({
    Key key,
    @required this.duration,
    @required int currentStep,
    @required Animation<int> firstRedAnimation,
    @required Animation<int> firstGrayAnimation,
    @required this.width,
    @required this.canAnimateSecondContainer,
    @required Animation<int> secondRedAnimation,
    @required Animation<int> secondGrayAnimation,
    @required this.canAnimateThirdContainer,
  })
      : _currentStep = currentStep,
        _firstRedAnimation = firstRedAnimation,
        _firstGrayAnimation = firstGrayAnimation,
        _secondRedAnimation = secondRedAnimation,
        _secondGrayAnimation = secondGrayAnimation,
        super(key: key);

  final Duration duration;
  final int _currentStep;
  final Animation<int> _firstRedAnimation;
  final Animation<int> _firstGrayAnimation;
  final double width;
  final bool canAnimateSecondContainer;
  final Animation<int> _secondRedAnimation;
  final Animation<int> _secondGrayAnimation;
  final bool canAnimateThirdContainer;

  @override
  Widget build(BuildContext context) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            backgroundColor: SharedUI.red,
            child: AnimatedSwitcher(
              duration: duration,
              child: (_currentStep >= 1)
                  ? Icon(
                Icons.done,
                color: SharedUI.white,
                key: ValueKey<int>(_currentStep),
              )
                  : Text(
                "1",
                style: SharedUI.textStyle(SharedUI.white),
              ),
            )),
        Flexible(
            flex: _firstRedAnimation.value,
            child: Container(
              height: 2,
              color: SharedUI.red,
            )),
        Flexible(
            flex: _firstGrayAnimation.value,
            child: Container(
              height: 2,
              color: SharedUI.gray,
            )),
        AnimatedContainer(
            width: width * 0.1,
            height: width * 0.1,
            duration: duration,
            decoration: BoxDecoration(
              color: // (_currentStep >= 1)
              (canAnimateSecondContainer == true)
                  ? SharedUI.red
                  : SharedUI.gray,
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            child: AnimatedSwitcher(
              duration: duration,
              child: (canAnimateSecondContainer == true && _currentStep > 1)
                  ? Icon(
                Icons.done,
                color: SharedUI.white,
                key: ValueKey<int>(_currentStep),
              )
                  : Text(
                "2",
                style: SharedUI.textStyle(SharedUI.white),
              ),
            )),
        Flexible(
            flex: _secondRedAnimation.value,
            child: Container(
              height: 2,
              color: SharedUI.red,
            )),
        Flexible(
            flex: _secondGrayAnimation.value,
            child: Container(
              height: 2,
              color: SharedUI.gray,
            )),
        AnimatedContainer(
          width: width * 0.1,
          height: width * 0.1,
          duration: duration,
          decoration: BoxDecoration(
            color: // (_currentStep >= 1)
            (canAnimateThirdContainer == true)
                ? SharedUI.red
                : SharedUI.gray,
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          child: Center(
            child: Text(
              "3",
              style: SharedUI.textStyle(SharedUI.white),
            ),
          ),
        ),
      ],
    );
  }
}
