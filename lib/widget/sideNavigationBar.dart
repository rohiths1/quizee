import 'package:flutter/material.dart';
import 'package:kbc_quiz/screen/aboutUs.dart';
import 'package:kbc_quiz/screen/homeScreen.dart';
import 'package:kbc_quiz/screen/howToUse.dart';
import 'package:kbc_quiz/screen/learderBoardScreen.dart';
import 'package:kbc_quiz/screen/loginScreen.dart';
import 'package:kbc_quiz/screen/profileScreen.dart';
import 'package:kbc_quiz/services/auth.dart';

class SideNav extends StatelessWidget {
  String name;
  String money;
  String rank;
  String proUrl;
  String level;
  SideNav(@required this.name, @required this.money, @required this.rank,
      @required this.proUrl, @required this.level);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/sideNavBackground.jpg"),
                  fit: BoxFit.cover),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ProfileScreen(
                            level: level,
                            money: money,
                            name: name,
                            rank: rank,
                            proUrl: proUrl,
                          )),
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(proUrl),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Rs.$money",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text("Leaderboard -",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("$rank th Rank",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.leaderboard,
              color: Colors.black,
            ),
            title: const Text(
              "Leaderboard",
              style: TextStyle(color: Colors.black),
            ),
            selected: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LearderBoardScreen(
                            name: name,
                            rank: rank,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.question_answer,
              color: Colors.black,
            ),
            title: const Text(
              "How To Use",
              style: TextStyle(color: Colors.black),
            ),
            selected: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HowToUseScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.face,
              color: Colors.black,
            ),
            title: const Text(
              "About Us",
              style: TextStyle(color: Colors.black),
            ),
            selected: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AbountUsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
            selected: true,
            onTap: () async {
              await signout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => loginScreen()));
            },
          ),
        
        ],
      ),
    );
  }

  
  Widget listItem(
      {required String label,
      required IconData icon,
      required BuildContext context,
      required MaterialPageRoute path}) {
    final color = Colors.black;
    final hovercolor = Colors.white60;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      hoverColor: hovercolor,
      title: Text(label, style: TextStyle(color: color)),
      onTap: () async {
        // await signout();
        Navigator.push(context, path);
      },
    );
  }
}
