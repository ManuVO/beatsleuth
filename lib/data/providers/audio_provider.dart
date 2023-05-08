import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum SourceMusic { popularArtist, search, library }

class AudioProvider with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlayed = false;
  bool isPaused = false;
  String? cover;
  String? title;
  String? artist;
  String? artistUrl;
  int? trackTimeMillis;
  Music? music;
  List<Music>? listMusic;
  bool loadingLibrary = false;
  SourceMusic? sourceMusic;

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
      Music music, List<Music> listMusic, SourceMusic source) async {
    this.music = music;
    cover = music.cover;
    title = music.title;
    artist = music.artist;
    artistUrl = music.artistUrl;
    trackTimeMillis = music.trackTimeMillis;
    this.listMusic = listMusic;
    isPaused = false;
    isPlayed = true;
    sourceMusic = source;

    await audioPlayer.setUrl(music.url);
    audioPlayer.play();

    notifyListeners();
  }

  Future seek(Duration time) async {
    await audioPlayer.seek(time);
  }

  Future addToLibrary() async {
    loadingLibrary = true;
    notifyListeners();
    //await AudioService.save(music!);
    loadingLibrary = false;
    notifyListeners();
  }

  Future next() async {
    List<int?> listIndexMusic = listMusic!
        .asMap()
        .entries
        .map((m) => m.value.id == this.music!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexMusic.removeWhere((element) => element == null);
    Music music = listMusic![
        (listIndexMusic.first! + 1) > (listMusic!.length - 1)
            ? (listIndexMusic.length - 1)
            : (listIndexMusic.first! + 1)];
    await playSource(music, listMusic!, sourceMusic!);
  }

  Future previous() async {
    List<int?> listIndexMusic = listMusic!
        .asMap()
        .entries
        .map((m) => m.value.id == this.music!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexMusic.removeWhere((element) => element == null);
    Music music = listMusic![
        (listIndexMusic.first! - 1) < 0 ? 0 : (listIndexMusic.first! - 1)];
    await playSource(music, listMusic!, sourceMusic!);
  }

  clean() async {
    await audioPlayer.pause();
    isPlayed = false;
    isPaused = false;
    cover = null;
    title = null;
    artist = null;
    artistUrl = null;
    trackTimeMillis = null;
    music = null;
    listMusic = null;
    loadingLibrary = false;

    notifyListeners();
  }

  removeMusic(Music music) async {
    if (this.music!.id == music.id) await next();
    listMusic = listMusic!.where((m) => m.id != music.id).toList();

    notifyListeners();
  }
}
