// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educazy/models/subject_model.dart';

class Marks {
  String testId;
  int score;
  Marks({
    required this.testId,
    required this.score,
  });

  Marks copyWith({
    String? testId,
    int? score,
  }) {
    return Marks(
      testId: testId ?? this.testId,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'testId': testId,
      'score': score,
    };
  }

  factory Marks.fromMap(Map<String, dynamic> map) {
    return Marks(
      testId: map['testId'] as String,
      score: map['score'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marks.fromJson(String source) =>
      Marks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Marks(testId: $testId, score: $score)';

  @override
  bool operator ==(covariant Marks other) {
    if (identical(this, other)) return true;

    return other.testId == testId && other.score == score;
  }

  @override
  int get hashCode => testId.hashCode ^ score.hashCode;
}
