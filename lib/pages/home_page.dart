import 'package:flutter/material.dart';
import 'package:beatsleuth/data/services/api_spotify_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final HomePageData data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class HomePageData {
  List<Map<String, dynamic>> albumes = [];
  List<Map<String, dynamic>> artistas = [];
  List<Map<String, dynamic>> canciones = [];
}

class _HomePageState extends State<HomePage> {
  // Instancia del servicio de Spotify
  final SpotifyService _spotifyService = SpotifyService();

  // Listas para almacenar los datos de álbumes, artistas y canciones
  List<Map<String, dynamic>> _albumes = [];
  List<Map<String, dynamic>> _artistas = [];
  List<Map<String, dynamic>> _canciones = [];

  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    // Carga los datos de álbumes, artistas y canciones al iniciar la página
    if(widget.data.albumes.isNotEmpty){
      _albumes = widget.data.albumes;
      _artistas = widget.data.artistas;
      _canciones = widget.data.canciones;

      _dataLoaded = true;
    }
    //_loadData();
  }

  // Método para cargar los datos de álbumes, artistas y canciones
  Future<void> _loadData() async {
    if (!_dataLoaded) {
      try {
        print('Cargando datos...');

        // Obtiene los álbumes más populares
        final albums = await _spotifyService.getPopularAlbums();

        // Obtiene los artistas más populares
        final artists = await _spotifyService.getPopularArtists();

        // Obtiene las canciones más populares
        final songs = await _spotifyService.getPopularSongs();

        // Actualiza el estado para mostrar los datos en la página
        setState(() {
          widget.data.albumes = albums;
          _albumes = albums;
          widget.data.artistas = artists;
          _artistas = artists;
          widget.data.canciones = songs;
          _canciones = songs;
        });
      } catch (e) {
        print('Error al cargar los datos: $e');
      }
      _dataLoaded = true;
    } 
    
  }

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
    return FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un widget de carga mientras se espera la respuesta de la API
            return Center(child: CircularProgressIndicator());
          } else {
            // Muestra el contenido de la página una vez que se han cargado los datos
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _getSaludo(),
                      style: Theme.of(context).textTheme.displayLarge,
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
                    height: 225,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: _albumes.length,
                      itemBuilder: (context, index) {
                        final album = _albumes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 16.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  album['images'][0]['url'],
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Flexible(
                                child: Text(
                                  '${album['name']} · ${album['artists'][0]['name']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
                    height: 225,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _artistas.length,
                        itemBuilder: (context, index) {
                          final artista = _artistas[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 16.0),
                            child: Column(
                              children: [
                                ClipOval(
                                    child: Image.network(
                                  artista['images'][0]['url'],
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )),
                                SizedBox(height: 8.0),
                                Flexible(
                                    child: Text(artista['name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center)),
                              ],
                            ),
                          );
                        }),
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
                      itemCount: _canciones.length,
                      itemBuilder: (context, index) {
                        final cancion = _canciones[index];
                        return ListTile(
                          leading: Image.network(
                              cancion['track']['album']['images'][0]['url'],
                              width: 50,
                              height: 50),
                          title: Text(cancion['track']['name']),
                          subtitle: Text(
                              '${cancion['track']['artists'][0]['name']} • ${Duration(milliseconds: cancion['track']['duration_ms']).toString().split('.')[0].substring(2)}'),
                          trailing: IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () => launchUrl(cancion['track']
                                  ['external_urls']['spotify'])),
                        );
                      })
                ],
              ),
            );
          }
        });
  }
}
