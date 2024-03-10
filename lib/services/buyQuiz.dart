import 'package:cloud_firestore/cloud_firestore.dart';
import 'localdb.dart';

class QuizDhandha {
  static Future<bool> buyQuiz(
      {required int QuizPrice, required String QuizID}) async {
    String user_id = "";
    bool paisaHaiKya = false;
    await localDB.getUserID().then((uID) {
      user_id = uID!;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user_id)
        .get()
        .then((user) {
      paisaHaiKya = QuizPrice <= int.parse(user.data()!["money"].toString());
    });

    if (paisaHaiKya) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user_id)
          .collection("unlock_quiz")
          .doc(QuizID)
          .set({"unlcoked_at": DateTime.now()});
      //money deduction function ad kortai hobay

      print("QUIZ IS UNLOCKED NOW");
      return true;
    } else {
      print("Earn money first".toUpperCase());
      return false;
    }
  }
}
