import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';
import 'dart:math';

import 'package:kbc_quiz/screen/questionScreen.dart';
import 'package:kbc_quiz/screen/quizIntro.dart';

class LoserScreen extends StatefulWidget {
  String queMoney;
  String correctAnswer;
  LoserScreen(this.queMoney, this.correctAnswer);

  @override
  _WinState createState() => _WinState();
}

class _WinState extends State<LoserScreen> {
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
                  Text("Ohh Sorry!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Correct Answer Is ${widget.correctAnswer}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text("You Lose",
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
                      Text("-${widget.queMoney == 2500 ? 0 : widget.queMoney}",
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
                    "assets/images/loser.jpg",
                    fit: BoxFit.contain,
                    scale: 1.0,
                  )),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.refresh),
                onPressed: () {
                  int money = int.parse(widget.queMoney);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => QuestionScreen(
                  //             quizID: widget.quizID, queMoney: (money) * 2)));
                },
              )
            ]),
          ],
        ));
  }
}
