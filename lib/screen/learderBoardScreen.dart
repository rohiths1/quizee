import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kbc_quiz/services/localdb.dart';

import 'homeScreen.dart';

class LearderBoardScreen extends StatefulWidget {
  String rank;
  String name;
  LearderBoardScreen({required this.rank, required this.name});

  @override
  State<LearderBoardScreen> createState() => _LearderBoardScreenState();
}

class _LearderBoardScreenState extends State<LearderBoardScreen> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> LeadersList = [];
  getLeaders() async {
    await FirebaseFirestore.instance
        .collection("users")
        .orderBy("money")
        .get()
        .then((value) {
      setState(() {
        LeadersList = value.docs.reversed.toList();
        widget.rank = (LeadersList.indexWhere(
                    (element) => element.data()["name"] == widget.name) +
                1)
            .toString();
      });
    });

    await localDB.saveRank(widget.rank);
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
    // TODO: implement initState
    super.initState();
    getLeaders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage("assets/images/leaderBoard.jpg"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 110),
              child: Text(
                "v1.0.0 Devlop by Jeetu",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Leaderboard",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: SizedBox(
                  height: 300,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    LeadersList[index].data()["photoUrl"]),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(LeadersList[index]
                                          .data()["name"]
                                          .toString()
                                          .length >=
                                      12
                                  ? "${(LeadersList[index].data()["name"]).toString().substring(0, 12)}..."
                                  : (LeadersList[index].data()["name"])
                                      .toString())
                            ],
                          ),
                          leading: Text(
                            "#${index + 1}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                              "Rs.${k_m_b_generator(int.parse(LeadersList[index].data()["money"].toString()))}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            thickness: 1,
                            color: Colors.deepPurple.shade200,
                            indent: 20,
                            endIndent: 20,
                          ),
                      itemCount: LeadersList.length),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
