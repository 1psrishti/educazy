// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:educazy/models/marks_model.dart';

class User {
  String name;
  String userId;
  String school;
  String className;
  List<String>? disabilities;
  List<Marks>? marksList;
  User({
    required this.name,
    required this.userId,
    required this.school,
    required this.className,
    this.disabilities,
    this.marksList,
  });

  User copyWith({
    String? name,
    String? userId,
    String? school,
    String? className,
    List<String>? disabilities,
    List<Marks>? marksList,
  }) {
    return User(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      school: school ?? this.school,
      className: className ?? this.className,
      disabilities: disabilities ?? this.disabilities,
      marksList: marksList ?? this.marksList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'school': school,
      'className': className,
      'disabilities': disabilities,
      'marksList': marksList!.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      userId: map['userId'] as String,
      school: map['school'] as String,
      className: map['className'] as String,
      disabilities: map['disabilities'] != null
          ? List<String>.from((map['disabilities'] as List<String>))
          : null,
      marksList: map['marksList'] != null
          ? List<Marks>.from(
              (map['marksList'] as List<int>).map<Marks?>(
                (x) => Marks.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, userId: $userId, school: $school, className: $className, disabilities: $disabilities, marksList: $marksList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.userId == userId &&
        other.school == school &&
        other.className == className &&
        listEquals(other.disabilities, disabilities) &&
        listEquals(other.marksList, marksList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        userId.hashCode ^
        school.hashCode ^
        className.hashCode ^
        disabilities.hashCode ^
        marksList.hashCode;
  }
}
