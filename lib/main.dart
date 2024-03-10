import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';
import 'package:kbc_quiz/screen/loginScreen.dart';
import 'package:kbc_quiz/screen/loserScreen.dart';
import 'package:kbc_quiz/screen/profileScreen.dart';
import 'package:kbc_quiz/screen/questionScreen.dart';
import 'package:kbc_quiz/screen/quizIntro.dart';
import 'package:kbc_quiz/screen/splashScreen.dart';
import 'package:kbc_quiz/screen/winScreen.dart';
import 'package:kbc_quiz/services/localdb.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  bool isSplace = true;
  getLoggedInState() async {
    await localDB.getUserID().then((value) {
      setState(() {
        isLogin = value.toString() != "null";
      });
    });
  }

  getSplash() {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        isSplace = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInState();
    getSplash();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isSplace ? SplashScreen() : (isLogin ? Home() : loginScreen()),
      ),
    );
  }
}
