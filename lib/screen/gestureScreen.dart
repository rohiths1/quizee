import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';

class gestureScreen extends StatefulWidget {
  const gestureScreen({super.key});

  @override
  State<gestureScreen> createState() => _gestureScreenState();
}

class _gestureScreenState extends State<gestureScreen> {
  int maxSeconds = 5;
  int seconds = 5;
  Timer? timer;

  counter() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds--);
      if (seconds == 0) {
        timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "You Will Be Redirected To Home Screen",
                      style: TextStyle(color: Colors.black38),
                    ),
                    TextSpan(
                      text: "\nIn",
                      style: TextStyle(color: Colors.black38),
                    ),
                    TextSpan(
                      text: " ${seconds} Seconds.",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/gestureBg.jpg",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ]));
  }
}
