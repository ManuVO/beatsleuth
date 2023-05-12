
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class HomePage extends StatefulWidget {
  final Function(int) changePage;

  const HomePage(this.changePage, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    _player = AudioPlayer();
    // Inicializar la sesión de audio
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Establecer la fuente de audio, por ejemplo, una URL
    await _player.setUrl('https://p.scdn.co/mp3-preview/989bcb16f82e4cfcbfebdf8cf0dd91abe86c84d1?cid=0b297fa8a249464ba34f5861d4140e58');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<PlayerState>(
          stream: _player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            if (playerState == null || playerState.processingState == ProcessingState.loading) {
              return CircularProgressIndicator();
            } else {
              return IconButton(
                icon: Icon(playerState.playing ? Icons.pause : Icons.play_arrow),
                iconSize: 64.0,
                onPressed: () {
                  _player.playing ? _player.pause() : _player.play();
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
