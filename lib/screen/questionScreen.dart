import 'dart:async';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/model/questionModel.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';
import 'package:kbc_quiz/screen/loserScreen.dart';
import 'package:kbc_quiz/screen/winScreen.dart';
import 'package:kbc_quiz/services/firedb.dart';
import 'package:kbc_quiz/services/quizQuestionCreater.dart';
import 'package:kbc_quiz/widget/lifelineWidget.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class QuestionScreen extends StatefulWidget {
  String quizID;
  int queMoney;
  QuestionScreen({required this.quizID, required this.queMoney});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<QuestionScreen> {
  QuestionModel questionModel = new QuestionModel();
  static int _currentQuestionNumber = 1;
  genQue() async {
    await QuizQueCreator.genQuizQue(widget.quizID, widget.queMoney)
        .then((queData) {
      setState(() {
        questionModel.question = queData["question"];
        questionModel.correct_answer = queData["correct_answer"];

        List options = [
          queData["op1"],
          queData["op2"],
          queData["op3"],
          queData["op4"],
        ];
        options.shuffle();

        questionModel.option1 = options[0];
        questionModel.option2 = options[1];
        questionModel.option3 = options[2];
        questionModel.option4 = options[3];
      });
    });
  }

  bool isChecked = false;
  bool op1Locked = false;
  bool op2Locked = false;
  bool op3Locked = false;
  bool op4Locked = false;
  bool isComplete = false;
  int maxSeconds = 30;
  int seconds = 30;
  Timer? timer;
  bool isOption = false;

  queTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      setState(() => seconds--);
      if (seconds == 0) {
        timer?.cancel();
        await fireDB.loseAmount((widget.queMoney ~/ 3));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoserScreen(
                    (widget.queMoney ~/ 3).toString(),
                    questionModel.correct_answer)));
      }
    });
  }

  getDone() {
    setState(() {
      if (_currentQuestionNumber == 9) {
        isComplete = true;
        timer?.cancel();
      }
      if (_currentQuestionNumber == 10) {
        _currentQuestionNumber = 1;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genQue();
    queTimer();
    getDone();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //   image: DecorationImage(
        // image: AssetImage("assets/img/background.png"),
        //),
      ),
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          timer?.cancel();
          isOpened ? timer?.cancel() : queTimer();
        },
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          "assets/images/coin.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "${widget.queMoney}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        drawer: LifelineDrawer(
          question: questionModel.question,
          opt1: questionModel.option1,
          opt2: questionModel.option2,
          opt3: questionModel.option3,
          opt4: questionModel.option4,
          correctAns: questionModel.correct_answer,
          currentQueMon: widget.queMoney,
          quizID: widget.quizID,
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                image: AssetImage("assets/images/questionBackground.jpg"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'Quite Game',
                                  desc: 'Do you want to quite the game?',
                                  btnCancelText: "No",
                                  btnOkText: "Yes",
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    timer?.cancel();
                                    _currentQuestionNumber = 1;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  },
                                )..show();
                              },
                              elevation: 0,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              child: Text(
                            "Question 0${_currentQuestionNumber.toString()}/09",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              questionModel.question,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.red.shade200,
                              width: 2,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "0:${seconds}",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent.shade700,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          print("Double tap to lock the anwser");
                        },
                        onDoubleTap: () {
                          timer?.cancel();

                          setState(() {
                            op1Locked = true;
                            timer?.cancel;
                            isOption = true;
                          });

                          Future.delayed(Duration(seconds: 2), () async {
                            if (questionModel.option1 ==
                                questionModel.correct_answer) {
                              _currentQuestionNumber++;
                              print(_currentQuestionNumber);
                              await fireDB.updateMoney(widget.queMoney);
                              isOption = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WinScreen(
                                      widget.queMoney.toString(),
                                      widget.quizID,
                                      isComplete),
                                ),
                              );
                              print("Right answer");
                            } else {
                              await fireDB.loseAmount((widget.queMoney ~/ 2));
                              isOption = false;
                              _currentQuestionNumber = 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoserScreen(
                                      (widget.queMoney ~/ 2).toString(),
                                      questionModel.correct_answer),
                                ),
                              );
                              print("Wrong answer");
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          padding: EdgeInsets.only(left: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                          decoration: BoxDecoration(
                            color: op1Locked
                                ? Colors.deepPurple.shade400.withOpacity(0.6)
                                : Color.fromARGB(54, 135, 135, 135)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: op1Locked
                                              ? Colors.white
                                              : Colors.black26,
                                          width: 1.5)),
                                  child: CircleAvatar(
                                    backgroundColor: op1Locked
                                        ? Colors.white
                                        : Color.fromARGB(54, 135, 135, 135)
                                            .withOpacity(0.1),
                                    child: Text(
                                      "A",
                                      style: TextStyle(
                                          color: op1Locked
                                              ? Colors.black38
                                              : Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    radius: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "${questionModel.option1}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: op1Locked
                                            ? Colors.white
                                            : Colors.black38,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print("Double tap to lock the anwser");
                        },
                        onDoubleTap: () {
                          timer?.cancel();

                          setState(() {
                            op2Locked = true;
                            timer?.cancel;
                            isOption = true;
                          });

                          Future.delayed(Duration(seconds: 2), () async {
                            if (questionModel.option2 ==
                                questionModel.correct_answer) {
                              _currentQuestionNumber++;
                              print(_currentQuestionNumber);
                              await fireDB.updateMoney(widget.queMoney);
                              isOption = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WinScreen(
                                      widget.queMoney.toString(),
                                      widget.quizID,
                                      isComplete),
                                ),
                              );
                              print("Right answer");
                            } else {
                              await fireDB.loseAmount((widget.queMoney ~/ 2));
                              isOption = false;
                              _currentQuestionNumber = 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoserScreen(
                                      (widget.queMoney ~/ 2).toString(),
                                      questionModel.correct_answer),
                                ),
                              );
                              print("Wrong answer");
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          padding: EdgeInsets.only(left: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                          decoration: BoxDecoration(
                            color: op2Locked
                                ? Colors.deepPurple.shade400.withOpacity(0.6)
                                : Color.fromARGB(54, 135, 135, 135)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: op2Locked
                                              ? Colors.white
                                              : Colors.black26,
                                          width: 1.5)),
                                  child: CircleAvatar(
                                    backgroundColor: op2Locked
                                        ? Colors.white
                                        : Color.fromARGB(54, 135, 135, 135)
                                            .withOpacity(0.1),
                                    child: Text(
                                      "B",
                                      style: TextStyle(
                                          color: op2Locked
                                              ? Colors.black38
                                              : Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    radius: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "${questionModel.option2}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: op2Locked
                                            ? Colors.white
                                            : Colors.black38,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print("Double tap to lock the anwser");
                        },
                        onDoubleTap: () {
                          timer?.cancel();

                          setState(() {
                            op3Locked = true;
                            timer?.cancel;
                            isOption = true;
                          });

                          Future.delayed(Duration(seconds: 2), () async {
                            if (questionModel.option3 ==
                                questionModel.correct_answer) {
                              _currentQuestionNumber++;
                              print(_currentQuestionNumber);
                              await fireDB.updateMoney(widget.queMoney);
                              isOption = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WinScreen(
                                      widget.queMoney.toString(),
                                      widget.quizID,
                                      isComplete),
                                ),
                              );
                              print("Right answer");
                            } else {
                              await fireDB.loseAmount((widget.queMoney ~/ 2));
                              isOption = false;
                              _currentQuestionNumber = 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoserScreen(
                                      (widget.queMoney ~/ 2).toString(),
                                      questionModel.correct_answer),
                                ),
                              );
                              print("Wrong answer");
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          padding: EdgeInsets.only(left: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                          decoration: BoxDecoration(
                            color: op3Locked
                                ? Colors.deepPurple.shade400.withOpacity(0.6)
                                : Color.fromARGB(54, 135, 135, 135)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: op3Locked
                                              ? Colors.white
                                              : Colors.black26,
                                          width: 1.5)),
                                  child: CircleAvatar(
                                    backgroundColor: op3Locked
                                        ? Colors.white
                                        : Color.fromARGB(54, 135, 135, 135)
                                            .withOpacity(0.1),
                                    child: Text(
                                      "C",
                                      style: TextStyle(
                                          color: op3Locked
                                              ? Colors.black38
                                              : Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    radius: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "${questionModel.option3}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: op3Locked
                                            ? Colors.white
                                            : Colors.black38,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          print("Double tap to lock the anwser");
                        },
                        onDoubleTap: () {
                          timer?.cancel();

                          setState(() {
                            op4Locked = true;
                            timer?.cancel;
                            isOption = true;
                          });

                          Future.delayed(Duration(seconds: 2), () async {
                            if (questionModel.option4 ==
                                questionModel.correct_answer) {
                              _currentQuestionNumber++;
                              print(_currentQuestionNumber);
                              await fireDB.updateMoney(widget.queMoney);
                              isOption = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WinScreen(
                                      widget.queMoney.toString(),
                                      widget.quizID,
                                      isComplete),
                                ),
                              );
                              print("Right answer");
                            } else {
                              await fireDB.loseAmount((widget.queMoney ~/ 2));
                              isOption = false;
                              _currentQuestionNumber = 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoserScreen(
                                      (widget.queMoney ~/ 2).toString(),
                                      questionModel.correct_answer),
                                ),
                              );
                              print("Wrong answer");
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          padding: EdgeInsets.only(left: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                          decoration: BoxDecoration(
                            color: op4Locked
                                ? Colors.deepPurple.shade400.withOpacity(0.6)
                                : Color.fromARGB(54, 135, 135, 135)
                                    .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: op4Locked
                                              ? Colors.white
                                              : Colors.black26,
                                          width: 1.5)),
                                  child: CircleAvatar(
                                    backgroundColor: op4Locked
                                        ? Colors.white
                                        : Color.fromARGB(54, 135, 135, 135)
                                            .withOpacity(0.1),
                                    child: Text(
                                      "D",
                                      style: TextStyle(
                                          color: op4Locked
                                              ? Colors.black38
                                              : Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    radius: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "${questionModel.option4}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: op4Locked
                                            ? Colors.white
                                            : Colors.black38,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "v1.0.0 Devlop by Jeetu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
