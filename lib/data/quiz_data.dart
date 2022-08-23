import 'package:educazy/enums/subject_type.dart';
import 'package:educazy/enums/test_status.dart';
import 'package:educazy/models/question_model.dart';
import 'package:educazy/models/subject_model.dart';
import 'package:educazy/models/test_model.dart';

List<Question> questions = <Question>[
  Question(
    id: '1',
    question: 'Which of the following cannot be polarised?',
    answers: ['Radiowaves', 'Transverse waves', 'Sound waves', 'X-Rays'],
  ),
  Question(
    id: '2',
    question: 'Which of the  cannot be polarised?',
    answers: ['Radiowaves', 'Transverse waves', 'Sound waves', 'X-Rays'],
  )
];

Test quizData = Test(
    testStatus: TestStatus.ACTIVE,
    id: 'PY123978',
    name: 'Physics',
    duration: Duration(minutes: 15),
    questions: questions);
