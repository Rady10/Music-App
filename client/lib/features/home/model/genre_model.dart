// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class GenreModel {
  final String id;
  final String name;
  final String color;
  final String url;
  GenreModel({
    required this.id,
    required this.name,
    required this.color,
    required this.url,
  });

  GenreModel copyWith({
    String? id,
    String? name,
    String? color,
    String? url,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
      'url': url,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name, color: $color, url: $url)';
  }

  @override
  bool operator ==(covariant GenreModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.color == color &&
      other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      color.hashCode ^
      url.hashCode;
  }
}
