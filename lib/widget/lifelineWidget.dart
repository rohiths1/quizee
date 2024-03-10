import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:kbc_quiz/screen/askTheExpert.dart';
import 'package:kbc_quiz/screen/audiencePoll.dart';
import 'package:kbc_quiz/screen/fiftyFifty.dart';
import 'package:kbc_quiz/screen/questionScreen.dart';
import 'package:kbc_quiz/services/localdb.dart';

class LifelineDrawer extends StatefulWidget {
  String question;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String quizID;
  String correctAns;
  int currentQueMon;

  LifelineDrawer({
    required this.question,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.correctAns,
    required this.quizID,
    required this.currentQueMon,
  });

  @override
  _Lifeline_DrawerState createState() => _Lifeline_DrawerState();
}

class _Lifeline_DrawerState extends State<LifelineDrawer> {
  Future<bool> checkAudAvail() async {
    bool AudAvail = true;
    await localDB.getAud().then((value) {
      AudAvail != value;
    });
    return AudAvail;
  }

  Future<bool> checkJokAvail() async {
    bool JokAvail = true;
    await localDB.getJoker().then((value) {
      print("JOKER IS");
      print(value);
      JokAvail != value;
    });
    return JokAvail;
  }

  Future<bool> checkf50Avail() async {
    bool f50Avail = true;
    await localDB.get50().then((value) {
      f50Avail != value;
    });
    return f50Avail;
  }

  Future<bool> checkExpAvail() async {
    bool ExpAvail = true;
    await localDB.getExp().then((value) {
      ExpAvail != value;
    });
    return ExpAvail;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Text("LifeLine",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (await checkAudAvail()) {
                      await localDB.saveAud(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AudiencePoll(
                                  question: widget.question,
                                  opt1: widget.opt1,
                                  opt2: widget.opt2,
                                  opt3: widget.opt3,
                                  opt4: widget.opt4,
                                  correctAns: widget.correctAns)));
                    } else {
                      print("AUDIENCE POLL IS ALREADY USED");
                    }
                  },
                  child: Column(
                    children: [
                      Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade200),
                            child: Icon(Icons.people,
                                size: 32, color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      Text("Audience\n Poll", textAlign: TextAlign.center),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (await checkf50Avail()) {
                      await localDB.save50(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Fifty50(
                                  opt1: widget.opt1,
                                  opt2: widget.opt2,
                                  opt3: widget.opt3,
                                  opt4: widget.opt4,
                                  question: widget.question,
                                  correctAns: widget.correctAns)));
                    } else {
                      print("YOU ALREADY USED FIFTY50 LIFELINE");
                    }
                  },
                  child: Column(
                    children: [
                      Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade200),
                            child: Icon(Icons.star_half,
                                size: 32, color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      Text("50 - 50 \nAnswer", textAlign: TextAlign.center),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (await checkExpAvail()) {
                      String ytUrl = "";
                      await FirebaseFirestore.instance
                          .collection("quizzes")
                          .doc(widget.quizID)
                          .collection("questions")
                          .where("question", isEqualTo: widget.question)
                          .get()
                          .then((value) async {
                        print("ASK THE EXPERT HERE");
                        print(widget.quizID);
                        print(widget.question);
                        value.docs.forEach((element) {
                          print("YT LINK IS HERE");

                          print(element.data()["AnswerYTLinkID"]);
                          ytUrl = element.data()["AnswerYTLinkID"];
                        });

                        print(value.docs.elementAt(0).data()["AnswerYTlinkID"]);
                        await localDB.saveExp(false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AskTheExpert(
                                    question: widget.question, yTURL: ytUrl)));
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade200),
                            child: Icon(Icons.desktop_mac,
                                size: 32, color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      Text("Ask The\n Expert", textAlign: TextAlign.center),
                    ],
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Text("PRIZES",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 500,
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        if (2500 * (pow(2, index + 1)) ==
                            widget.currentQueMon) {
                          return ListTile(
                            tileColor: Colors.deepPurpleAccent,
                            leading: Text(
                              "${index + 1}.",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            title: Text(
                              "Rs.${2500 * (pow(2, index + 1))}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            trailing: Icon(
                              Icons.circle,
                              color: Colors.deepOrange.shade200,
                            ),
                          );
                        }
                        return ListTile(
                          leading: Text(
                            "${index + 1}.",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          title: Text(
                            "Rs.${2500 * (pow(2, index + 1))}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          trailing: Icon(Icons.circle),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
