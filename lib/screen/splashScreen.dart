import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: TextLiquidFill(
            text: 'Quizzee',
            waveColor: Colors.black,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
