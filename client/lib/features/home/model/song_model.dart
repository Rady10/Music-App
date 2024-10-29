// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class SongModel {
  final String id;
  final String name;
  final String artist;
  final String genre;
  final String thumbnail_url;
  final String song_url;
  final String color;
  SongModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.genre,
    required this.thumbnail_url,
    required this.song_url,
    required this.color,
  });

  SongModel copyWith({
    String? id,
    String? name,
    String? artist,
    String? genre,
    String? thumbnail_url,
    String? song_url,
    String? color,
  }) {
    return SongModel(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      genre: genre ?? this.genre,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'artist': artist,
      'genre': genre,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
      'color': color,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      artist: map['artist'] ?? '',
      genre: map['genre'] ?? '',
      thumbnail_url: map['thumbnail_url'] ?? '',
      song_url: map['song_url'] ?? '',
      color: map['color'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) => SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, name: $name, artist: $artist, genre: $genre, thumbnail_url: $thumbnail_url, song_url: $song_url, color: $color)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.artist == artist &&
      other.genre == genre &&
      other.thumbnail_url == thumbnail_url &&
      other.song_url == song_url &&
      other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      artist.hashCode ^
      genre.hashCode ^
      thumbnail_url.hashCode ^
      song_url.hashCode ^
      color.hashCode;
  }
}
