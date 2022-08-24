// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:educazy/enums/test_status.dart';
import 'package:educazy/models/question_model.dart';

class Test {
  String id;
  String name;
  Duration duration;
  List<Question> questions = [];
  TestStatus testStatus;
  Test({
    required this.testStatus,
    required this.id,
    required this.name,
    required this.duration,
    required this.questions,
  });

  Test copyWith({
    String? id,
    String? name,
    Duration? duration,
    List<Question>? questions,
    TestStatus? testStatus,
  }) {
    return Test(
      testStatus: testStatus ?? this.testStatus,
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'duration': duration.inSeconds,
      'type': testStatus.index,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      testStatus: TestStatus.values[map['type'] as int],
      id: map['id'] as String,
      name: map['name'] as String,
      duration: Duration(seconds: map['duration']),
      questions: List<Question>.from(
        (map['questions'] as List<int>).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) =>
      Test.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Test(id: $id, name: $name, duration: $duration, questions: $questions)';
  }

  @override
  bool operator ==(covariant Test other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.duration == duration &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ duration.hashCode ^ questions.hashCode;
  }
}
