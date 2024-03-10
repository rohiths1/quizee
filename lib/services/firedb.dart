import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kbc_quiz/services/localdb.dart';

class fireDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewUser(String name, String email, String photoUrl, String uid) async {
    final User? current_user = _auth.currentUser;
    if (await getUser()) {
      print("user already exist...");
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current_user!.uid)
          .set({
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "money": 0,
        "rank": "NA",
        "level": "0",
      }).then((value) async => {
                await localDB.saveLevel("0"),
                await localDB.saveMoney(0),
                await localDB.saveRank("NA"),
                print("User registered successfully...."),
              });
    }
  }

  static updateMoney(int amount) async {
    if (amount != 2500) {
      final FirebaseAuth _myauth = FirebaseAuth.instance;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_myauth.currentUser!.uid)
          .get()
          .then((value) async {
        await localDB.saveMoney((value.data()!["money"] + amount));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_myauth.currentUser!.uid)
            .update({"money": value.data()!["money"] + amount});
        print("total amount ${value.data()!["money"] + amount}");
      });
    }
  }

  static loseAmount(int amount) async {
    final FirebaseAuth _myauth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_myauth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.data()!["money"] - amount != 0) {
        await localDB.saveMoney((value.data()!["money"] - amount));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_myauth.currentUser!.uid)
            .update({"money": value.data()!["money"] - amount});
        print("total amount ${value.data()!["money"] - amount}");
      }
    });
  }

  static unlockMoneyDeduction(int amount) async {
    final FirebaseAuth _myauth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_myauth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.data()!["money"] - amount != 0) {
        await localDB.saveMoney((value.data()!["money"] - amount));
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_myauth.currentUser!.uid)
            .update({"money": value.data()!["money"] - amount});
        print("total amount ${value.data()!["money"] - amount}");
      }
    });
  }

  Future<bool> getUser() async {
    final User? current_user = _auth.currentUser;
    String user = " ";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(current_user!.uid)
        .get()
        .then((value) async {
      user = value.data().toString();
      print(user);
      await localDB.saveMoney(999989);
      await localDB.saveRank("444");
      await localDB.saveLevel("45");
    });
    if (user == "null") {
      return false;
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current_user!.uid)
          .get()
          .then((value) async => {
                user = value.data().toString(),
                print(user),
                await localDB.saveMoney(value["money"]),
                await localDB.saveRank(value["rank"]),
                await localDB.saveLevel(value["level"]),
              });
      return true;
    }
  }
}
