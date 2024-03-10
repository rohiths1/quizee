import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:kbc_quiz/screen/questionScreen.dart';
import 'package:kbc_quiz/services/buyQuiz.dart';
import 'package:kbc_quiz/services/checkUnlockQuiz.dart';
import 'package:kbc_quiz/services/localdb.dart';

class QuizIntro extends StatefulWidget {
  String QuizName;
  String QuizImgUrl;
  String QuizDuration;
  String QuizAbout;
  String QuizId;
  String QuizPrice;
  QuizIntro(
      {required this.QuizAbout,
      required this.QuizDuration,
      required this.QuizImgUrl,
      required this.QuizName,
      required this.QuizId,
      required this.QuizPrice});

  @override
  _QuizIntroState createState() => _QuizIntroState();
}

class _QuizIntroState extends State<QuizIntro> {
  setLifeLAvail() async {
    await localDB.saveAud(true);
    await localDB.saveJoker(true);
    await localDB.save50(true);
    await localDB.saveExp(true);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuestionScreen(quizID: widget.QuizId, queMoney: 5000)));
  }

  bool quizIsUnlcoked = false;
  getQuizUnlockStatus() async {
    await CheckQuizUnlock.checkQuizUnlockStatus(widget.QuizId)
        .then((unlockStatus) {
      setState(() {
        quizIsUnlcoked = unlockStatus;
      });
    });
  }

  @override
  void initState() {
    getQuizUnlockStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(
            quizIsUnlcoked ? Icons.arrow_forward_ios : Icons.lock,
          ),
          onPressed: () async {
            quizIsUnlcoked
                ? setLifeLAvail()
                : QuizDhandha.buyQuiz(
                        QuizID: widget.QuizId,
                        QuizPrice: int.parse(widget.QuizPrice))
                    .then((quizKharidLiya) {
                    if (quizKharidLiya) {
                      setState(() {
                        quizIsUnlcoked = true;
                      });
                      return AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: "Congratulation",
                        desc: 'Congratulation You Ulock New Quiz!',
                      )..show();
                    } else {
                      return AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: "Soory",
                        desc: 'You Have Not Enough Money To By This Quiz!',
                        btnCancelOnPress: () {},
                      )..show();
                    }
                  });
          }),

      // 
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 1.8,
              image: AssetImage("assets/images/quizIntroBackground.jpg"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.QuizName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timelapse_outlined),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Duration ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.QuizDuration} Minutes",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.topic_outlined),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "About Quiz",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.QuizAbout,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                quizIsUnlcoked
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.attach_money_outlined),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Unlock Money",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
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
                                  " ${widget.QuizPrice}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
