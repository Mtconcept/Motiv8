import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motiv8/constants/colors.dart';
import 'package:motiv8/screens/home.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Coloors.kPrimaryColors,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '"',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 64,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  color: Coloors.kWhite),
            ),
            SizedBox(
              height: 36,
            ),
            FadeAnimatedTextKit(
              repeatForever: true,
              text: ['Be\nMotivated', 'Be\nInspired', 'Be\nGreat'],
              textStyle: GoogleFonts.playfairDisplay(
                  decoration: TextDecoration.none,
                  fontSize: 36,
                  color: Coloors.kWhite),
            ),
            SizedBox(
              height: 104,
            ),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                  color: Coloors.kBtnColor,
                  borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                  color: Coloors.kBtnColor,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QuoteHome()));
                  },
                  child: Text('Get Started',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Coloors.kWhite))),
            )
          ],
        ),
      ),
    );
  }
}
