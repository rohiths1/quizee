import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AudiencePoll extends StatefulWidget {
  String question;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String correctAns;
  AudiencePoll(
      {required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.correctAns});
  @override
  _AudiencePollState createState() => _AudiencePollState();
}

class _AudiencePollState extends State<AudiencePoll> {
  int maxSeconds = 20;
  int seconds = 20;
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
    VotingMachine();
    counter();
  }

  int opt1Votes = 0;
  int opt2Votes = 0;
  int opt3Votes = 0;
  int opt4Votes = 0;
  bool isVoting = true;
  VotingMachine() {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        if (widget.opt1 == widget.correctAns) {
          opt1Votes = Random().nextInt(100);
        } else {
          opt1Votes = Random().nextInt(40);
        }

        if (widget.opt2 == widget.correctAns) {
          opt2Votes = Random().nextInt(100);
        } else {
          opt2Votes = Random().nextInt(40);
        }

        if (widget.opt3 == widget.correctAns) {
          opt3Votes = Random().nextInt(100);
        } else {
          opt3Votes = Random().nextInt(40);
        }

        if (widget.opt4 == widget.correctAns) {
          opt4Votes = Random().nextInt(100);
        } else {
          opt4Votes = Random().nextInt(40);
        }
        isVoting = false;
      });

      Future.delayed(Duration(seconds: 10), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.2,
                image: AssetImage("assets/images/audiencepollBackground.jpg"),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Audience Poll Lifeline",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Question",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.question}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isVoting
                              ? "Audience is Voting"
                              : "Here are the Results",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    isVoting
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade400
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.5)),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    "A",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  radius: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "${widget.opt1}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                "${opt1Votes}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              radius: 16,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade400
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.5)),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    "B",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  radius: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "${widget.opt2}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                "${opt2Votes}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              radius: 16,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade400
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.5)),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    "C",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  radius: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "${widget.opt3}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                "${opt3Votes}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              radius: 16,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    padding: EdgeInsets.only(left: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade400
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.5)),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    "D",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  radius: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "${widget.opt4}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                "${opt4Votes}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              radius: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "You Will Be Redirected To Quiz Screen",
                            style: TextStyle(color: Colors.black38),
                          ),
                          TextSpan(
                            text: "\nIn",
                            style: TextStyle(color: Colors.black38),
                          ),
                          TextSpan(
                            text: " 20 Seconds.",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: "\n\n0:${seconds}",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 110),
                      child: Text(
                        "v1.0.0 Devlop by Jeetu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
