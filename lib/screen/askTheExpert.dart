import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AskTheExpert extends StatefulWidget {
  String question;
  String yTURL;
  AskTheExpert({required this.question, required this.yTURL});

  @override
  _AskTheExpertState createState() => _AskTheExpertState();
}

class _AskTheExpertState extends State<AskTheExpert> {
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
    counter();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      showSimpleNotification(
          Text(connected ? "Connected to internet" : "No internet connection"),
          background: connected ? Colors.green : Colors.red);
    });
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
                          "Ask The Expert Lifeline",
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
                          "Video Solution",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: widget.yTURL,
                            flags: YoutubePlayerFlags(
                              hideControls: true,
                              controlsVisibleAtStart: false,
                              autoPlay: true,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                        ),
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
