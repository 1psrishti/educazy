// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educazy/models/subject_model.dart';

class Marks {
  Subject subject;
  int? acquiredMarks;
  int? totalMarks;
  String? grade;
  Marks({
    required this.subject,
    this.acquiredMarks,
    this.totalMarks,
    this.grade,
  });

  Marks copyWith({
    Subject? subject,
    int? acquiredMarks,
    int? totalMarks,
    String? grade,
  }) {
    return Marks(
      subject: subject ?? this.subject,
      acquiredMarks: acquiredMarks ?? this.acquiredMarks,
      totalMarks: totalMarks ?? this.totalMarks,
      grade: grade ?? this.grade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject.toMap(),
      'acquiredMarks': acquiredMarks,
      'totalMarks': totalMarks,
      'grade': grade,
    };
  }

  factory Marks.fromMap(map) {
    return Marks(
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      acquiredMarks:
          map['acquiredMarks'] != null ? map['acquiredMarks'] as int : null,
      totalMarks: map['totalMarks'] != null ? map['totalMarks'] as int : null,
      grade: map['grade'] != null ? map['grade'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marks.fromJson(String source) =>
      Marks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Marks(subject: $subject, acquiredMarks: $acquiredMarks, totalMarks: $totalMarks, grade: $grade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Marks &&
        other.subject == subject &&
        other.acquiredMarks == acquiredMarks &&
        other.totalMarks == totalMarks &&
        other.grade == grade;
  }

  @override
  int get hashCode {
    return subject.hashCode ^
        acquiredMarks.hashCode ^
        totalMarks.hashCode ^
        grade.hashCode;
  }
}
