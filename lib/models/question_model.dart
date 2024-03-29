// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  String question;
  List<String> answers;
  String id;
  String? markedAnswer;
  Question({
    required this.question,
    required this.answers,
    required this.id,
    this.markedAnswer,
  });

  Question copyWith({
    String? question,
    List<String>? answers,
    String? id,
    String? markedAnswer,
  }) {
    return Question(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      id: id ?? this.id,
      markedAnswer: markedAnswer ?? this.markedAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statement': question,
      'option': answers,
      '_id': id,
      'markedAnswer': markedAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['statement'] as String,
      answers: List<String>.from((map['option']) as List<String>),
      id: map['_id'] as String,
      markedAnswer:
          map['markedAnswer'] != null ? map['markedAnswer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(statement: $question, option: $answers, _id: $id, markedAnswer: $markedAnswer)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        listEquals(other.answers, answers) &&
        other.id == id &&
        other.markedAnswer == markedAnswer;
  }

  @override
  int get hashCode {
    return question.hashCode ^
        answers.hashCode ^
        id.hashCode ^
        markedAnswer.hashCode;
  }
}
