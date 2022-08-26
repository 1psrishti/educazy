import 'package:educazy/data/quiz_data.dart';
import 'package:educazy/main.dart';
import 'package:educazy/models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

  void markAnswer(index) {
    Question currentQues = quizData.questions[_currentQuesIndex];
    currentQues.markedAnswer = currentQues.answers[index];
    notifyListeners();
  }

  void nextQuestion() {
    if (quizData.questions.length > _currentQuesIndex + 1) {
      _currentQuesIndex = _currentQuesIndex + 1;
    } else {}
  }

  void prevQuestion() {
    if (_currentQuesIndex - 1 >= 0) {
      _currentQuesIndex = _currentQuesIndex - 1;
    }
  }

  void readQuestion() {
    speak(quizData.questions[_currentQuesIndex].question);
  }

  readOptions() async {
    var sentence =
        "First option is ${quizData.questions[_currentQuesIndex].answers[0]}   Second option is ${quizData.questions[_currentQuesIndex].answers[1]}  Third option is ${quizData.questions[_currentQuesIndex].answers[2]} Fourth option is ${quizData.questions[_currentQuesIndex].answers[3]}";
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setPitch(0.7);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(sentence);
  }
}
