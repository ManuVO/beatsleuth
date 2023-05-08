import 'package:beatsleuth/data/models/artist.dart';
import 'package:beatsleuth/data/models/customImage.dart';

class Album {
  String? name;
  String? id;
  List<Artist>? artists;
  List<CustomImage>? images;
  String? releaseDate;
  int? totalTracks;
  String? label;
  String? albumType;
  Map<String, String>? externalUrls;
  
  Album({
    required this.name,
    required this.id,
    this.artists,
    this.images,
    this.releaseDate,
    this.totalTracks,
    this.label,
    this.albumType,
    this.externalUrls,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      id: json['id'],
      artists: json['artists'] != null ? List<Artist>.from(json['artists'].map((artist) => Artist.fromJson(artist))) : null,
      images: json['images'] != null ? List<CustomImage>.from(json['images'].map((image) => CustomImage.fromJson(image))) : null,
      releaseDate: json['release_date'],
      totalTracks: json['total_tracks'],
      label: json['label'],
      albumType: json['album_type'],
      externalUrls: json['external_urls'] != null ? Map<String, String>.from(json['external_urls']) : null,
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
