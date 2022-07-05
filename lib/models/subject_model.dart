// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Subject {
  String name;
  String id;
  Subject({
    required this.name,
    required this.id,
  });

  Subject copyWith({
    String? name,
    String? id,
  }) {
    return Subject(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Subject(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Subject && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
