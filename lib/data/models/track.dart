
import 'package:beatsleuth/data/models/album.dart';
import 'package:beatsleuth/data/models/artist.dart';

class Track {
  final Album album;
  final List<Artist> artists;
  final Duration durationMs;
  final Map<String, String> externalUrls;
  final String href;
  final String id;
  final bool isPlayable;
  final String name;
  final String previewUrl;
  final int trackNumber;
  final String uri;

  Track({
    required this.album,
    required this.artists,
    required this.durationMs,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.isPlayable,
    required this.name,
    required this.previewUrl,
    required this.trackNumber,
    required this.uri,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      album: Album.fromJson(json['album']),
      artists: List<Artist>.from(
          json['artists'].map((artist) => Artist.fromJson(artist))),
      durationMs: json['duration_ms'],
      externalUrls: Map<String, String>.from(json['external_urls']),
      href: json['href'],
      id: json['id'],
      isPlayable: json['is_playable'],
      name: json['name'],
      previewUrl: json['preview_url'],
      trackNumber: json['track_number'],
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'album': album.toJson(),
      'artists': artists.map((artist) => artist.toJson()).toList(),
      'duration_ms': durationMs,
      'external_urls': externalUrls,
      'href': href,
      'id': id,
      'is_playable': isPlayable,
      'name': name,
      'preview_url': previewUrl,
      'track_number': trackNumber,
      'uri': uri,
    };
  }
}
