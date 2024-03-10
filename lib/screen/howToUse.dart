import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      body: Stack(children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage("assets/images/howToUse.jpg"),
                  fit: BoxFit.contain),
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "How To Use Quizzee",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Introduction",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Quizze is a fun and engaging quiz app that lets you test your knowledge on a wide range of topics. Here are some tips to help you get started:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "1. Taking a Quiz",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "To take a quiz, simply select a category and tap on the 'Start Quiz' button. You will be presented with a series of questions that you need to answer as quickly and accurately as possible. Once you have answered all the questions, you will be given a score based on your performance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "2. Customizing Your Quiz",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Quizze allows you to customize your quiz experience by selecting the number of questions, the difficulty level, and the time limit. To access these options, tap on the 'Customize' button before starting a quiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "3. Viewing Your Results",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "After completing a quiz, you can view your results by tapping on the 'Results' button. This will show you your score, the number of questions you answered correctly, and the time it took you to complete the quiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "4. Participating in Daily\nChallenges",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Quizze offers daily challenges that let you compete against other players from around the world. To participate, simply tap on the 'Daily Challenge' button and answer as many questions as you can within the time limit.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "5. Earning Badges and Achievements",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Quizze rewards you with badges and achievements for completing certain tasks and reaching certain milestones. Keep an eye out for these rewards and try to collect them all!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
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
            ),
          ),
        ),
      ]),
    );
  }
}
