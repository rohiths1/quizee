import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/screen/gestureScreen.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';
import 'dart:math';

import 'package:kbc_quiz/screen/questionScreen.dart';

class WinScreen extends StatefulWidget {
  String queMoney;
  String quizID;
  bool isComplete;
  WinScreen(this.queMoney, this.quizID, this.isComplete);

  @override
  _WinState createState() => _WinState();
}

class _WinState extends State<WinScreen> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    setState(() {
      initController();
    });
    confettiController.play();
  }

  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Congratulations!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Your Answer Is Correct",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text("You Won",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          "assets/images/coin.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(widget.queMoney,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      child: Image.asset(
                    "assets/images/win.jpg",
                    fit: BoxFit.contain,
                    scale: 1.0,
                  )),
                ],
              ),
              widget.isComplete
                  ? FloatingActionButton(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.home),
                      onPressed: () {
                        int money = int.parse(widget.queMoney);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => gestureScreen()));
                      },
                    )
                  : FloatingActionButton(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        int money = int.parse(widget.queMoney);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionScreen(
                                    quizID: widget.quizID,
                                    queMoney: (money) * 2)));
                      },
                    )
            ]),
            buildConfettiWidget(confettiController, pi / 2),
          ],
        ));
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(40, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 20,
        minBlastForce: 8,
        emissionFrequency: 0.2,
        numberOfParticles: 15,
        gravity: 0.01,
      ),
    );
  }
}
