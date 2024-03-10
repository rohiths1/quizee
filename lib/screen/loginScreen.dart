import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kbc_quiz/screen/loader.dart';
import 'package:kbc_quiz/screen/splashScreen.dart';
import 'package:kbc_quiz/services/auth.dart';
import 'package:overlay_support/overlay_support.dart';

import 'homeScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      showSimpleNotification(
          Text(connected ? "Connected to internet" : "No internet connection"),
          background: connected ? Colors.green : Colors.red);
    });
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
                height: 20,
              ),
              SignInButton(
                Buttons.GoogleDark,
                padding: EdgeInsets.all(5),
                text: "Continue with google",
                onPressed: () async {
                  await signInWithGoogle();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => 
                          LoaderScreen()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text("By Continuing, You Are Agree With our TnC"),
            ],
          ),
        ));
  }
}
