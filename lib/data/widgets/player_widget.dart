import 'package:flutter/material.dart';
import 'package:beatsleuth/data/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class PlayerWidget extends StatelessWidget {
  
  final AudioProvider audioProvider;
  const PlayerWidget({required this.audioProvider});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Barra de información de la canción
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Text(
                  audioProvider.title ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  audioProvider.artist ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Imagen de la canción
          Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: audioProvider.cover != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(audioProvider.cover!, fit: BoxFit.cover),
                  )
                : Container(color: Colors.grey[900]),
          ),

          // Barra de progreso dinámica
          StreamBuilder(
            stream: audioProvider.audioPlayer.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Duration? duration = snapshot.data;
                final double progress = duration!.inMilliseconds / audioProvider.durationMs!.inMilliseconds;
                return LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                );
              } else {
                return LinearProgressIndicator(
                  value: 0.0,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                );
              }
            },
          ),

          // Controles de reproducción
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white, size: 40),
                  onPressed: () => audioProvider.previous(),
                ),
                if (audioProvider.isPaused)
                  IconButton(
                    icon: Icon(Icons.play_circle_filled, color: Colors.green, size: 80),
                    onPressed: () => audioProvider.play(),
                  )
                else
                  IconButton(
                    icon: Icon(Icons.pause_circle_filled, color: Colors.green, size: 80),
                    onPressed: () => audioProvider.pause(),
                  ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
                  onPressed: () => audioProvider.next(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
