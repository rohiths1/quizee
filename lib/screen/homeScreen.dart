import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/commingSoon.dart';
import 'package:kbc_quiz/screen/profileScreen.dart';
import 'package:kbc_quiz/screen/quizIntro.dart';
import 'package:kbc_quiz/services/homeFireDB.dart';
import 'package:kbc_quiz/services/localdb.dart';
import 'package:kbc_quiz/widget/sideNavigationBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "User Name";
  String money = "--";
  String lead = "---";
  String proUrl = "---";
  String level = "0";
  String rankerPhotoUrl = "";
  String rankerName = "";
  int rankerMoney = 0;
  late List quizzes;
  getUserDet() async {
    await localDB.getName().then((value) {
      setState(() {
        name = value.toString();
      });
    });

    await localDB.getMoney().then((value) {
      setState(() {
        money = value.toString();
      });
    });

    await localDB.getRank().then((value) {
      setState(() {
        lead = value.toString();
      });
    });

    await localDB.getUrl().then((value) {
      setState(() {
        proUrl = value.toString();
      });
    });

    await localDB.getLevel().then((value) {
      setState(() {
        level = value.toString();
      });
    });
  }

  getQuiz() async {
    await homeFireDB.getQuizzes().then((returned_quiz) {
      setState(() {
        quizzes = returned_quiz;
      });
    });
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> LeadersList = [];

  getLeaders() async {
    await FirebaseFirestore.instance
        .collection("users")
        .orderBy("money")
        .get()
        .then((value) {
      setState(() {
        LeadersList = value.docs.reversed.toList();
      });
    });
    if (LeadersList.isNotEmpty) {
      print(LeadersList[0].data()["photoUrl"]);
      print(LeadersList[0].data()["name"]);
      print(LeadersList[0].data()["money"]);
      rankerPhotoUrl = LeadersList[0].data()["photoUrl"];
      rankerName = LeadersList[0].data()["name"];
      rankerMoney = LeadersList[0].data()["money"];
    } else {
      print("The list is empty.");
    }
  }

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDet();
    getQuiz();
    getLeaders();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 60,
            title: Center(
              child: Text(
                "Quizzee",
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.deepPurple),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => ProfileScreen(
                                level: level,
                                money: money,
                                name: name,
                                rank: lead,
                                proUrl: proUrl,
                              )),
                        ));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(proUrl),
                  ),
                ),
              ),
            ],
          ),
          drawer: SideNav(name, money, lead, proUrl, level),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/slider1.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/slider2.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/slider3.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                      options: CarouselOptions(
                          height: 180,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ComingSoon()));
                              },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/catagoery1.jpg"),
                                  backgroundColor: Colors.purple,
                                  radius: 35),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Fact",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ComingSoon()));
                              },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/catagoery2.jpg"),
                                  backgroundColor: Colors.redAccent,
                                  radius: 35),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Mystery",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ComingSoon()));
                              },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/catagoery3.jpg"),
                                  backgroundColor: Colors.green,
                                  radius: 35),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "FAQ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizIntro(
                                          QuizName: (quizzes[1])["quiz_name"],
                                          QuizImgUrl:
                                              (quizzes[1])["quiz_image"],
                                          QuizAbout: (quizzes[1])["about_quiz"],
                                          QuizDuration:
                                              (quizzes[1])["duration"],
                                          QuizId: (quizzes[1])["Quizid"],
                                          QuizPrice:
                                              (quizzes[1])["unlock_money"],
                                        )));
                          },
                          child: Card(
                            elevation: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/GKK.jpg"),
                                      fit: BoxFit.cover)),
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Top Player In This Week",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Last Updated 5 Days Ago",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    rankerPhotoUrl,
                                  ),
                                  backgroundColor: Colors.grey,
                                  radius: 50,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      //LeadersList[0].data()["name"],
                                      rankerName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Player ID - ABD553",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "${k_m_b_generator(int.parse(rankerMoney.toString()))}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )
                              ],
                            )
                          ])),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Unlock New Quizzes",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      //MATH
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizIntro(
                                                        QuizName: (quizzes[3])[
                                                            "quiz_name"],
                                                        QuizImgUrl: (quizzes[
                                                            3])["quiz_image"],
                                                        QuizAbout: (quizzes[3])[
                                                            "about_quiz"],
                                                        QuizDuration: (quizzes[
                                                            3])["duration"],
                                                        QuizId: (quizzes[3])[
                                                            "Quizid"],
                                                        QuizPrice: (quizzes[3])[
                                                            "unlock_money"],
                                                      )));
                                        },
                                        child: Card(
                                          elevation: 8,
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/MATHEMATICs.jpg"),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 10),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizIntro(
                                                        QuizName: (quizzes[4])[
                                                            "quiz_name"],
                                                        QuizImgUrl: (quizzes[
                                                            4])["quiz_image"],
                                                        QuizAbout: (quizzes[4])[
                                                            "about_quiz"],
                                                        QuizDuration: (quizzes[
                                                            4])["duration"],
                                                        QuizId: (quizzes[4])[
                                                            "Quizid"],
                                                        QuizPrice: (quizzes[4])[
                                                            "unlock_money"],
                                                      )));
                                        },
                                        child: Card(
                                          elevation: 8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/slider2.jpg"),
                                                    fit: BoxFit.cover)),
                                            height: 150,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/slider3.jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 10),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                          height: 150,
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/HISTORY.jpg"),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.purple, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "We Are Working To Add\nMore Quizzes.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Give Your Ideas For Quizzes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  icon: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.amberAccent,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComingSoon()));
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.white),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.white), 
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  hintText: "Politics, Geography, ....",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "v1.0.0 Devlop by Jeetu",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
