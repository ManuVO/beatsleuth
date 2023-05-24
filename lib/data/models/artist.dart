import 'package:beatsleuth/data/models/customImage.dart';

class Artist {
  final String id;
  final String name;
  final List<String> genres;
  final List<CustomImage> images;
  final int popularity;
  final String type;
  final String uri;
  final bool isFollowed;

  Artist({
    required this.id,
    required this.name,
    required this.genres,
    required this.images,
    required this.popularity,
    required this.type,
    required this.uri,
    required this.isFollowed,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      genres: List<String>.from(json['genres'] ?? []),
      images: json['images'] != null
          ? (json['images'] as List<dynamic>)
              .map((image) => CustomImage.fromJson(image))
              .toList()
          : [],
      popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
      isFollowed: json['is_followed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genres': genres,
      'images': images.map((image) => image.toJson()).toList(),
      'popularity': popularity,
      'type': type,
      'uri': uri,
      'is_followed': isFollowed,
    };
  }
}


