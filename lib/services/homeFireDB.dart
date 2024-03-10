import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class homeFireDB {
  static Future<List<Map<String,dynamic>>> getQuizzes() async {
    List<Map<String, dynamic>> all_quiz = [];
    await FirebaseFirestore.instance
        .collection("quizzes")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((quiz) {
        Map<String, dynamic> myQuiz = quiz.data();
        myQuiz["Quizid"] = quiz.reference.id;
        print(quiz.data());
        all_quiz.add(myQuiz);
      });
    });
    return all_quiz;
  }
}
