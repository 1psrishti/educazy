import 'package:educazy/data/quiz_data.dart';
import 'package:educazy/models/question_model.dart';
import 'package:flutter/cupertino.dart';

class QuizData extends ChangeNotifier {
  Question? _question;
  int _currentQuesIndex = 0;

  Question getQuestion() => quizData.questions[_currentQuesIndex];
  int getCurentQuesIndex() => _currentQuesIndex;

  void setCurrentQuesIndex(int val) {
    print("val: $val");
    if (val > 0 && val < quizData.questions.length) {
      _currentQuesIndex = val;
      notifyListeners();
    }
  }

  void markAnswer(String answer) {
    Question currentQues = quizData.questions[_currentQuesIndex];
    if (currentQues.answers.contains(answer)) {
      currentQues.markedAnswer = answer;
    }
    notifyListeners();
  }
}
