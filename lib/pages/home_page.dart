// home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  String _getSaludo() {
    final hora = DateTime.now().hour;
    if (hora < 12) {
      return '¡Buenos días!';
    } else if (hora < 18) {
      return '¡Buenas tardes!';
    } else {
      return '¡Buenas noches!';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo de álbumes
    final List<Map<String, dynamic>> albumes = [
      {
        'titulo': 'Álbum 1',
        'artista': 'Artista 1',
        'imagen': 'https://picsum.photos/100',
      },
      {
        'titulo': 'Álbum 2',
        'artista': 'Artista 2',
        'imagen': 'https://picsum.photos/100',
      },
      // ...
    ];

    // Lista de ejemplo de artistas
    final List<Map<String, dynamic>> artistas = [
      {
        'nombre': 'Artista 1',
        'imagen': 'https://picsum.photos/100',
      },
      {
        'nombre': 'Artista 2',
        'imagen': 'https://picsum.photos/100',
      },
      // ...
    ];

    // Lista de ejemplo de canciones
    final List<Map<String, dynamic>> canciones = [
      {
        'titulo': 'Canción 1',
        'artista': 'Artista 1',
        'duracion': '3:45',
      },
      {
        'titulo': 'Canción 2',
        'artista': 'Artista 2',
        'duracion': '4:12',
      },
      // ...
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _getSaludo(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Álbumes populares',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemCount: albumes.length,
              itemBuilder: (context, index) {
                final album = albumes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(album['imagen']),
                      ),
                      SizedBox(height: 8.0),
                      Text('${album['titulo']} · ${album['artista']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Artistas populares',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: artistas.length,
              itemBuilder: (context, index) {
                final artista = artistas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      ClipOval(
                          child: Image.network(artista['imagen'],
                              width: 100, height: 100)),
                      SizedBox(height: 8.0),
                      Text(artista['nombre']),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Canciones populares',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: canciones.length,
            itemBuilder: (context, index) {
              final cancion = canciones[index];
              return ListTile(
                title: Text(cancion['titulo']),
                subtitle:
                    Text('${cancion['artista']} • ${cancion['duracion']}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
