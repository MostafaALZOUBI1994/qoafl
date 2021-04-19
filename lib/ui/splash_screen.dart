
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:qawafel/ui/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double variable=300;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 1000)).then((value) => {
    move()
    });

    super.initState();
  }
  move(){
    setState(() {
      variable=0.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(top: variable,duration:Duration(milliseconds: 2500),
            child: Container(height: 100,width: 100,child: Image.asset("assets/logoluncher.png"),)
          ),
        ],
      ),
    );
  }
}
