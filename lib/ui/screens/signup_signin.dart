import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:qawafel/ui/widgets/date.dart';
import 'package:qawafel/ui/widgets/snakbar.dart';
import 'package:qawafel/ui/widgets/textfield.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';
import '../../repository/userRepo.dart';

class Signup_SigninScreen extends StatefulWidget {
  @override
  _Signup_SigninScreenState createState() => _Signup_SigninScreenState();
}

class _Signup_SigninScreenState extends State<Signup_SigninScreen> {
  final controller =
      PageController(viewportFraction: 1.0, keepPage: false, initialPage: 0);
  TextEditingController emailUserNameController;
  TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController registerPasswordController;
  TextEditingController passwordConfirmController;
  TextEditingController locationController;
  bool selected = false;
  bool _onFirstPage = true;
  @override
  void initState() {
    // TODO: implement initState
    emailUserNameController = TextEditingController();
    passwordController = TextEditingController();
    registerPasswordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backColor,
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(38),
          ),
          Center(
            child: Image.asset("assets/Logosign.png"),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(26),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (selected == false && _onFirstPage == true) {
                  } else {
                    setState(() {
                      selected = false;
                      _onFirstPage = true;
                    });
                  }
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      color: selected ? grey : Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(14),
              ),
              Container(
                width: 2,
                height: ScreenUtil().setHeight(23),
                color: Colors.black,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(14),
              ),
              InkWell(
                onTap: () {
                  if (selected == true && _onFirstPage == false) {
                  } else {
                    setState(() {
                      selected = true;
                      _onFirstPage = false;
                    });
                  }
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      color: selected ? Theme.of(context).primaryColor : grey),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              reverse: !_onFirstPage,
              transitionBuilder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                );
              },
              child: _onFirstPage
                  ? Container(
                      key: UniqueKey(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(19),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(14)),
                                    child: Text(
                                      "Insert UserName Or email",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(11)),
                                child: TextFieldWidget(
                                  passfieled: false,
                                  controller: emailUserNameController,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(18),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(14)),
                                    child: Text(
                                      "Insert Password",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(11)),
                                child: TextFieldWidget(passfieled: true,
                                  controller: passwordController,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              buttonWidget(
                                  "sign in", Theme.of(context).primaryColor,
                                  () async {
                                if (emailUserNameController.text == "" ||
                                    passwordController.text == "") {
                                  showSnackBar(context, "fill fields please");
                                } else {
                              await    UserRepo(context).signIn(
                                      emailUserNameController.text,
                                      passwordController.text);

                                  Navigator.pop(context);
                                  setState(() {

                                  });
                                }
                              }),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                              /*
                              Container(
                                width: ScreenUtil().setHeight(162),
                                height: ScreenUtil().setHeight(162),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: const Color(0xffffffff),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(11),
                                    ),
                                    Image.asset("assets/face.png"),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(12.4)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign in",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Face-ID",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(14),
                                    ),
                                    Text(
                                      "Lock Directly at your\n front camera to use\nFace ID",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                               */
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      key: UniqueKey(),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(14)),
                                      child: Text(
                                        "Insert your Email",
                                        style: TextStyle(
                                            color: grey,
                                            fontSize:
                                                ScreenUtil().setSp(12)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(11)),
                                  child: TextFieldWidget(
                                    passfieled: false,
                                    controller: emailController,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(18),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(14)),
                                      child: Text(
                                        "Insert your Name",
                                        style: TextStyle(
                                            color: grey,
                                            fontSize:
                                                ScreenUtil().setSp(12)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(11)),
                                  child: TextFieldWidget(
                                    passfieled: false,
                                    controller: nameController,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(18),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(14)),
                                      child: Text(
                                        "Insert your password",
                                        style: TextStyle(
                                            color: grey,
                                            fontSize:
                                                ScreenUtil().setSp(12)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(11)),
                                  child: TextFieldWidget(passfieled: true,
                                    controller: registerPasswordController,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(18),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(14)),
                                      child: Text(
                                        "Re-Insert your password",
                                        style: TextStyle(
                                            color: grey,
                                            fontSize:
                                                ScreenUtil().setSp(12)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(11)),
                                  child: TextFieldWidget(passfieled: true,
                                    controller: passwordConfirmController,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(18),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(24),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(83)),
                                  child: buttonWidget("Sign up",
                                      Theme.of(context).primaryColor, () async {
                                    if (nameController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        registerPasswordController
                                            .text.isEmpty ||
                                        passwordConfirmController
                                            .text.isEmpty) {
                                      showSnackBar(context, "Please Fill All Fields");
                                    }else{
                                      if(registerPasswordController.text !=passwordConfirmController.text){
                                        showSnackBar(context, "Password doesn't match confirm password");
                                      }
                                   await   UserRepo(context)
                                          .signUp(
                                              nameController.text,
                                              emailController.text,
                                              registerPasswordController
                                                  .text,
                                              passwordConfirmController
                                                  .text)
                                          .then((value) {
                                        setState(() {
                                          if (value == null ||
                                              value == false) {
                                            _onFirstPage = false;
                                            selected = true;
                                          } else {
                                            _onFirstPage = true;
                                            selected = false;
                                            controller.animateToPage(
                                              0,
                                              duration: Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        });
                                      });
                                    }
                                  }),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(27),
                                ),
                                /*
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ScreenUtil().setWidth(83)),
                                  child: buttonWidget(
                                      "Complete your information",
                                      Theme.of(context).accentColor, () {
                                    controller.animateToPage(
                                      1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(24),
                                ),

                                 */
                              ],
                            ),
                          ),

                        ],
                      )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(String text, Color color, Function f) {
    return InkWell(
      onTap: f,
      child: Container(
        height: ScreenUtil().setHeight(31),
        width: ScreenUtil().setWidth(209),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
          color: color,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
