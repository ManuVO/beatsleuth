import 'package:beatsleuth/data/models/artist.dart';
import 'package:beatsleuth/data/models/customImage.dart';

class Album {
  final String name;
  final String id;
  final List<Artist> artists;
  final List<CustomImage> images;
  final String releaseDate;
  final int totalTracks;
  final String label;
  final String albumType;
  final Map<String, String> externalUrls;
  
  Album({
    required this.name,
    required this.id,
    required this.artists,
    required this.images,
    required this.releaseDate,
    required this.totalTracks,
    required this.label,
    required this.albumType,
    required this.externalUrls,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      id: json['id'],
      artists: json['artists'] = List<Artist>.from(json['artists'].map((artist) => Artist.fromJson(artist))),
      images: json['images'] = List<CustomImage>.from(json['images'].map((image) => CustomImage.fromJson(image))),
      releaseDate: json['release_date'],
      totalTracks: json['total_tracks'],
      label: json['label'],
      albumType: json['album_type'],
      externalUrls: json['external_urls'] = Map<String, String>.from(json['external_urls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'artists': artists?.map((artist) => artist.toJson()).toList(),
      'images': images?.map((image) => image.toJson()).toList(),
      'release_date': releaseDate,
      'total_tracks': totalTracks,
      'label': label,
      'album_type': albumType,
      'external_urls': externalUrls,
    };
  }
}
