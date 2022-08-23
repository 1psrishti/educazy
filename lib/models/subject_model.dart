// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:educazy/enums/subject_type.dart';

class Subject {
  SubjectType name;
  String? id;
  Subject({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id ?? "", 'name': name.str};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      name: SubjectType.values[map['name'] as int],
      id: map['id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source) as Map<String, dynamic>);
}
