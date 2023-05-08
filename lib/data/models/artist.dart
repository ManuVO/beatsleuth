import 'package:beatsleuth/data/models/customImage.dart';

class Artist {
  String? id;
  String? name;
  List<String>? genres;
  List<CustomImage>? images;
  int? popularity;
  String? type;
  String? uri;
  bool? isFollowed;

  Artist({
    required this.id,
    required this.name,
    this.genres,
    this.images,
    this.popularity,
    this.type,
    this.uri,
    this.isFollowed,
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
      'images': images?.map((image) => image.toJson()).toList(),
      'popularity': popularity,
      'type': type,
      'uri': uri,
      'is_followed': isFollowed,
    };
  }
}


