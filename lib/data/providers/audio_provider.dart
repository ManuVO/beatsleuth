import 'package:beatsleuth/data/models/track.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum SourceTrack { popularArtist, search, library }

class AudioProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlayed = false;
  bool isPaused = false;
  String? cover;
  String? title;
  String? artist;
  String? artistUrl;
  Duration? durationMs;
  Track? track;
  List<Track>? listTrack;
  bool loadingLibrary = false;
  SourceTrack? sourceTrack;

  Future pause() async {
    isPaused = true;
    isPlayed = false;
    await audioPlayer.pause();

    notifyListeners();
  }

  Future play() async {
    isPlayed = true;
    isPaused = false;
    audioPlayer.play();

    notifyListeners();
  }

  Future playSource(
      Track track, List<Track> listTrack, SourceTrack source) async {
    this.track = track;
    cover = track.album.images.first.url;
    title = track.name;
    artist = track.artists.first.name;
    artistUrl = track.artists.first.uri;
    durationMs = track.durationMs;
    this.listTrack = listTrack;
    isPaused = false;
    isPlayed = true;
    sourceTrack = source;

    await audioPlayer.setUrl(track.previewUrl);
    
    audioPlayer.play();

    notifyListeners();
  }

  Future seek(Duration time) async {
    await audioPlayer.seek(time);
  }

  Future addToLibrary() async {
    loadingLibrary = true;
    notifyListeners();
    //await AudioService.save(track!);
    loadingLibrary = false;
    notifyListeners();
  }

  Future next() async {
    List<int?> listIndexTrack = listTrack!
        .asMap()
        .entries
        .map((m) => m.value.id == this.track!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexTrack.removeWhere((element) => element == null);
    Track track = listTrack![
        (listIndexTrack.first! + 1) > (listTrack!.length - 1)
            ? (listIndexTrack.length - 1)
            : (listIndexTrack.first! + 1)];
    await playSource(track, listTrack!, sourceTrack!);
  }

  Future previous() async {
    List<int?> listIndexTrack = listTrack!
        .asMap()
        .entries
        .map((m) => m.value.id == this.track!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexTrack.removeWhere((element) => element == null);
    Track track = listTrack![
        (listIndexTrack.first! - 1) < 0 ? 0 : (listIndexTrack.first! - 1)];
    await playSource(track, listTrack!, sourceTrack!);
  }

  clean() async {
    await audioPlayer.pause();
    isPlayed = false;
    isPaused = false;
    cover = null;
    title = null;
    artist = null;
    artistUrl = null;
    durationMs = null;
    track = null;
    listTrack = null;
    loadingLibrary = false;

    notifyListeners();
  }

  removeTrack(Track track) async {
    if (this.track!.id == track.id) await next();
    listTrack = listTrack!.where((m) => m.id != track.id).toList();

    notifyListeners();
  }
}
