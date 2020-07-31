import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motiv8/constants/colors.dart';
import 'package:motiv8/screens/onboardScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = 30;
  double height = 30;

  void animation() {
    setState(() {
      width = 0;
      height = 0;
    });
  }

  @override
  void initState() {
    Future.delayed(
        Duration(
          milliseconds: 200,
        ),
        () => animation());

    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Onboard())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloors.kPrimaryColors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 1000),
                width: width,
                height: height,
                onEnd: () {
                  setState(() {
                    width = width == 30 ? 0 : 30;
                    height = height == 30 ? 0 : 30;
                  });
                },
                decoration: BoxDecoration(
                  color: Coloors.kBtnColor,
                  borderRadius: BorderRadius.circular(20),
                )),
            RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Motiv',
                  style: GoogleFonts.playfairDisplay(
                      color: Coloors.kWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '8',
                  style: GoogleFonts.playfairDisplay(
                      color: Coloors.kBtnColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
