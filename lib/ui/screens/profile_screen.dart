import 'dart:io';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qawafel/repository/userRepo.dart';
import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
          child: Container(
            width: ScreenUtil().setWidth(375),
            height: ScreenUtil().setHeight(813),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(25)),
              color: const Color(0xfff9f9f9),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(33.3),
                    ),
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: kUser.userInfo.avatar == null
                          ? AssetImage("assets/user.png")
                          : NetworkImage(mediaUrl + kUser.userInfo.avatar),
                      backgroundColor: backColor,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    Text(
                      "My Profile",
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                InkWell(
                  onTap: () async {
                    final imageFile =
                        await picker.getImage(source: ImageSource.gallery);

                    setState(() {
                      if (imageFile != null) {
                        _image = File(imageFile.path);
                      }
                    });
                    await UserRepo(context).uploadFileFromDio(_image);
                    await UserRepo(context)
                        .getUserProfile(kUser.accessToken, kUser.userId);
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(11)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            left: ScreenUtil().setWidth(35),
                            right: ScreenUtil().setWidth(200)),
                        child: Text("Change Your Image"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(11)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            left: ScreenUtil().setWidth(35),
                            right: ScreenUtil().setWidth(250)),
                        child: Text("Contact us"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(11)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                      color: const Color(0xffffffff),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                          left: ScreenUtil().setWidth(35),
                          right: ScreenUtil().setWidth(230)),
                      child: Text("Privacy Policy"),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(11)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                      color: const Color(0xffffffff),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 13,
                          bottom: 13,
                          left: ScreenUtil().setWidth(35),
                          right: ScreenUtil().setWidth(250)),
                      child: Text("Our Offices"),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                InkWell(
                  onTap: () async {
                    bool signOut = await UserRepo(context).signOut();
                    signOut ? Navigator.pop(context) : () {};
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(11)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                        color: const Color(0xffffffff),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 13,
                            bottom: 13,
                            left: ScreenUtil().setWidth(35),
                            right: ScreenUtil().setWidth(265)),
                        child: Text("Sign Out"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),

              ],
            ),
          ),
        ));
  }
}
