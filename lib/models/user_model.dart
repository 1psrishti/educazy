// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:educazy/models/marks_model.dart';

class UserModel {
  String username;
  String name;
  String userId;
  String school;
  String className;
  List<String>? disabilities;
  List<Marks>? marksList = [];
  UserModel({
    required this.username,
    required this.name,
    required this.userId,
    required this.school,
    required this.className,
    this.disabilities,
    this.marksList,
  });

  UserModel copyWith({
    String? username,
    String? name,
    String? userId,
    String? school,
    String? className,
    List<String>? disabilities,
    List<Marks>? marksList,
  }) {
    return UserModel(
      username: username ?? this.username,
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
      'username': username,
      'name': name,
      '_id': userId,
      'school': school,
      'class': className,
      'disabilities': disabilities,
      'scores':
          marksList != null ? marksList!.map((x) => x.toMap()).toList() : [],
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      name: map['name'] as String,
      userId: map['_id'] as String,
      school: map['school'] as String,
      className: map['class'] as String,
      disabilities: map['disabilities'] != null
          ? List<String>.from((map['disabilities']))
          : null,
      marksList: map['scores'] != null
          ? List<Marks>.from(
              (map['scores']).map<Marks?>(
                (x) => Marks.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, name: $name, _id: $userId, school: $school, class: $className, disabilities: $disabilities, scores: $marksList)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.name == name &&
        other.userId == userId &&
        other.school == school &&
        other.className == className &&
        listEquals(other.disabilities, disabilities) &&
        listEquals(other.marksList, marksList);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        school.hashCode ^
        className.hashCode ^
        disabilities.hashCode ^
        marksList.hashCode;
  }
}
