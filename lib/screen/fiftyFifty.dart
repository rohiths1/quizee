import 'dart:async';

import 'package:flutter/material.dart';

class Fifty50 extends StatefulWidget {
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String question;
  String correctAns;
  Fifty50(
      {required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.question,
      required this.correctAns});

  @override
  _Fifty50State createState() => _Fifty50State();
}

class _Fifty50State extends State<Fifty50> {
  late String WrongOpt1;
  late String WrongOpt2;
  bool opt1 = false;
  bool opt2 = false;
  bool opt3 = false;
  bool opt4 = false;
  int maxSeconds = 20;
  int seconds = 20;
  Timer? timer;
  bool isWaiting = true;
  List WrongOption = [];
  fetchWrongOptons() {
    setState(() {
      if (widget.opt1 != widget.correctAns) {
        WrongOption.add(widget.opt1);
      }
      if (widget.opt2 != widget.correctAns) {
        WrongOption.add(widget.opt2);
      }

      if (widget.opt3 != widget.correctAns) {
        WrongOption.add(widget.opt3);
      }
      if (widget.opt4 != widget.correctAns) {
        WrongOption.add(widget.opt4);
      }
    });
  }

  wrongOptionsCheck() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        if (widget.opt1 == WrongOption[0] || widget.opt1 == WrongOption[1]) {
          opt1 = true;
        }
        if (widget.opt2 == WrongOption[0] || widget.opt2 == WrongOption[1]) {
          opt2 = true;
        }
        if (widget.opt3 == WrongOption[0] || widget.opt3 == WrongOption[1]) {
          opt3 = true;
        }
        if (widget.opt4 == WrongOption[0] || widget.opt4 == WrongOption[1]) {
          opt4 = true;
        }
        isWaiting = false;
      });
    });
  }

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
    fetchWrongOptons();
    wrongOptionsCheck();
    counter();
    Future.delayed(Duration(seconds: 20), () {
      Navigator.pop(context);
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
                          "50 - 50 Lifeline",
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
                          "Incorrect Options",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Center(
                        child: isWaiting
                            ? Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        padding: EdgeInsets.only(left: 15),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: opt1
                                              ? Colors.redAccent.shade700
                                                  .withOpacity(0.6)
                                              : Colors.deepPurple.shade400
                                                  .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Text(
                                                        "A",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      radius: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      "${widget.opt1}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: opt1
                                                      ? Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                        )
                                                      : Container(),
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        padding: EdgeInsets.only(left: 15),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: opt2
                                              ? Colors.redAccent.shade700
                                                  .withOpacity(0.6)
                                              : Colors.deepPurple.shade400
                                                  .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Text(
                                                        "B",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      radius: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      "${widget.opt2}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: opt2
                                                      ? Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                        )
                                                      : Container(),
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        padding: EdgeInsets.only(left: 15),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: opt3
                                              ? Colors.redAccent.shade700
                                                  .withOpacity(0.6)
                                              : Colors.deepPurple.shade400
                                                  .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Text(
                                                        "C",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      radius: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      "${widget.opt3}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: opt3
                                                      ? Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                        )
                                                      : Container(),
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        padding: EdgeInsets.only(left: 15),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: opt4
                                              ? Colors.redAccent.shade700
                                                  .withOpacity(0.6)
                                              : Colors.deepPurple.shade400
                                                  .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Text(
                                                        "D",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      radius: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      "${widget.opt4}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: opt4
                                                      ? Icon(
                                                          Icons.close,
                                                          color: Colors
                                                              .redAccent
                                                              .shade700,
                                                        )
                                                      : Container(),
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
                              )),
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
