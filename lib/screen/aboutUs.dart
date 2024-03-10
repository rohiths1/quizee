import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AbountUsScreen extends StatefulWidget {
  const AbountUsScreen({super.key});

  @override
  State<AbountUsScreen> createState() => _AbountUsScreenState();
}

class _AbountUsScreenState extends State<AbountUsScreen> {
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
                  image: AssetImage("assets/images/aboutUs.jpg"),
                  fit: BoxFit.contain),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 110),
            child: Text(
              "v1.0.0 Devlop by Jeetu",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Quizzee is a fun and engaging quiz app that lets you test your knowledge on a wide range of topics. With features like daily challenges, leaderboards, and custom quizzes, Quizze is the perfect app for anyone who loves trivia and learning new things.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Developer Information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/devloper.jpg'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abhijit Maiti',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '(Jeetu)\nLead Developer',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/devloper.jpg'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abhijit Maiti',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '(Jeetu)\nUX Designer',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: support@quizze.com\nTwitter: @quizzeapp\nFacebook: quizzeofficial',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Version Information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Version: 1.0.0\nLast updated: March 15, 2023',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 60),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Copyright © And ",
                      style: TextStyle(color: Colors.black38),
                    ),
                    TextSpan(
                      text: "Legal\nInformation",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
