// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  String name;
  String id;
  Book({
    required this.name,
    required this.id,
  });

  Book copyWith({
    String? name,
    String? id,
  }) {
    return Book(
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

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Book(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
