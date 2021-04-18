
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:qawafel/ui/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: 'assets/logoluncher.png',
      backGroundColor: backColor,
      animationEffect: 'zoom-in',
      logoSize: 200,
      home: MainScreen(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,

    );
  }
}
