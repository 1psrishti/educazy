import 'package:educazy/models/marks_model.dart';
import 'package:educazy/models/subject_model.dart';
import 'package:educazy/models/user_model.dart';

UserModel student = UserModel(
    name: 'Kartikey Mahawar',
    userId: 'RA2011032010041',
    school: 'Hartmann College',
    className: '10',
    disabilities: [
      "Dumb,Blind"
    ],
    marksList: [
      Marks(
          subject: Subject(id: '1', name: 'Computer Science'),
          acquiredMarks: 50,
          totalMarks: 100),
      Marks(
          subject: Subject(id: '2', name: 'Physics'),
          acquiredMarks: 50,
          totalMarks: 100),
      Marks(
          subject: Subject(id: '3', name: 'Mathematics'),
          acquiredMarks: 34,
          totalMarks: 100),
      Marks(
          subject: Subject(id: '4', name: 'Chemistry'),
          acquiredMarks: 95,
          totalMarks: 100),
    ]);
