import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:kbc_quiz/services/auth.dart';

import 'homeScreen.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  bool isLoad = false;

  getLoad() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoad = true;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/images/login.jpg",
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "Welcome To\nQuizzee",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
          ),
          isLoad ? Container() : CircularProgressIndicator(),
          SizedBox(
            height: 25,
          ),
          Text("By Continuing, You Are Agree With our TnC"),
        ],
      )),
    );
  }
}
