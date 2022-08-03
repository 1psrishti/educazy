import 'package:educazy/models/question_model.dart';
import 'package:educazy/models/test_model.dart';

List<Question> questions = <Question>[
  Question(
      question: 'Which of the following cannot be polarised?',
      answers: ['Radiowaves', 'Transverse waves', 'Sound waves', 'X-Rays'],
      correctAnswer: 'Radiowaves'),
  Question(
      question: 'Which of the  cannot be polarised?',
      answers: ['Radiowaves', 'Transverse waves', 'Sound waves', 'X-Rays'],
      correctAnswer: 'Radiowaves')
];

Test quizData = Test(
    id: 'PY123978',
    name: 'Physics',
    duration: Duration(minutes: 15),
    questions: questions);
