import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class SpotifyService {
  // Reemplaza estos valores con tus propias credenciales de Spotify
  final String clientId = '2efb385b388f49ce9af41d6c0dbf0022';
  final String clientSecret = 'ee75efb22e724f42ae109b159a928d95';

  // URL base de la API de Spotify
  final String baseUrl = 'https://api.spotify.com/v1';

  // Token de acceso a la API de Spotify
  String? _accessToken;

  // Método para autenticarse en la API de Spotify
  Future<void> _authenticate() async {
    // Codifica las credenciales en base64
    final String credentials =
        base64Url.encode(utf8.encode('$clientId:$clientSecret'));

    // Realiza una petición POST para obtener el token de acceso
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    // Decodifica la respuesta y guarda el token de acceso
    final data = jsonDecode(response.body);
    _accessToken = data['access_token'];
  }

  Future<List<Map<String, dynamic>>> getPopularAlbums() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Obtiene la lista de reproducción más popular en Estados Unidos
    final playlistResponse = await http.get(
      Uri.parse(
          '$baseUrl/browse/categories/toplists/playlists?country=US&limit=1'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    final playlistData = jsonDecode(playlistResponse.body);
    final playlistId = playlistData['playlists']['items'][0]['id'];

    // Obtiene las canciones de la lista de reproducción
    final tracksResponse = await http.get(
      Uri.parse('$baseUrl/playlists/$playlistId/tracks?limit=50'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    final tracksData = jsonDecode(tracksResponse.body);

    // Extrae los datos de todos los álbumes de las canciones
    final allAlbums =
        tracksData['items'].map((item) => item['track']['album']).toList();

    // Mezcla aleatoriamente la lista de álbumes
    allAlbums.shuffle();

    // Selecciona los primeros 6 álbumes de la lista mezclada
    final popularAlbums =
        List<Map<String, dynamic>>.from(allAlbums.take(6).toList());

    // Devuelve los datos de los álbumes
    return popularAlbums;
  }

  // Método para obtener los artistas más populares
  Future<List<Map<String, dynamic>>> getPopularArtists() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Obtiene el año actual
    final int currentYear = DateTime.now().year;

    // Realiza una petición GET para buscar artistas populares del año actual
    final response = await http.get(
      Uri.parse('$baseUrl/search?q=year:$currentYear&type=artist&limit=50'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y obtiene la lista de artistas
    final data = jsonDecode(response.body);
    final allArtists = data['artists']['items'];

    // Mezcla aleatoriamente la lista de artistas
    allArtists.shuffle();

    // Selecciona los primeros 6 artistas de la lista mezclada
    final popularArtists =
        List<Map<String, dynamic>>.from(allArtists.take(6).toList());

    return popularArtists;
  }

  // Método para obtener las canciones más populares
  Future<List<Map<String, dynamic>>> getPopularSongs() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener las canciones más populares
    final response = await http.get(
      Uri.parse('$baseUrl/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks?limit=50'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de las canciones
    final data = jsonDecode(response.body);
    final allSongs = data['items'];

    // Mezcla aleatoriamente la lista de canciones
    allSongs.shuffle();

    // Selecciona las primeras 10 canciones de la lista mezclada
    final popularSongs =
        List<Map<String, dynamic>>.from(allSongs.take(10).toList());

    return popularSongs;
  }

  Future<List<Map<String, dynamic>>> getTopPlaylists() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener las playlists más populares de Estados Unidos
    final response = await http.get(
      Uri.parse(
          '$baseUrl/browse/categories/toplists/playlists?country=US&limit=10'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de las playlists
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['playlists']['items']);
  }

  Future<List<Map<String, dynamic>>> search(String query) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para buscar canciones, álbumes y artistas
    final response = await http.get(
      Uri.parse('$baseUrl/search?q=$query&type=track,album,artist&limit=20'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y extrae los datos de las canciones, álbumes y artistas
    final data = jsonDecode(response.body);
    final tracks = data['tracks']['items'];
    final albums = data['albums']['items'];
    final artists = data['artists']['items'];

    // Combina los resultados en una sola lista y devuelve los datos
    return [
      ...List<Map<String, dynamic>>.from(tracks),
      ...List<Map<String, dynamic>>.from(albums),
      ...List<Map<String, dynamic>>.from(artists),
    ];
  }

  Future<Map<String, dynamic>> getAudioFeatures(String trackId) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener las características de audio de la canción
    final response = await http.get(
      Uri.parse('$baseUrl/audio-features/$trackId'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de las características de audio
    final data = jsonDecode(response.body);
    return data;
  }

  Future<List<Map<String, dynamic>>> getTrackRecommendations(
      String trackId) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener recomendaciones basadas en la canción
    final response = await http.get(
      Uri.parse('$baseUrl/recommendations?seed_tracks=$trackId&limit=10'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de las canciones recomendadas
    final data = jsonDecode(response.body);
    final trackRecommendations =
        List<Map<String, dynamic>>.from(data['tracks']);
    return trackRecommendations;
  }

  // Método para obtener una cancion
  Future<Map<String, dynamic>> getTrack(String trackId) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener información sobre la canción
    final response = await http.get(
      Uri.parse('$baseUrl/tracks/$trackId'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de la cancion
    final data = jsonDecode(response.body);

    return Map<String, dynamic>.from(data);
  }

  Future<Map<String, dynamic>> getAlbum(String albumId) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener información sobre el álbum
    final response = await http.get(
      Uri.parse('$baseUrl/albums/$albumId'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    final data = jsonDecode(response.body);
    return data;
  }

  // Método para obtener la imagen del album de una cancion
  Future<String> getTrackImage(String trackId) async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener información sobre la canción
    final response = await http.get(
      Uri.parse('$baseUrl/tracks/$trackId'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y obtiene los datos de la canción
    final data = jsonDecode(response.body);

    // Accede a la información del álbum y obtiene la URL de la imagen
    final album = data['album'];
    final imageUrl = album['images'][0]['url'];

    return imageUrl;
  }

  Future<Map<String, dynamic>> getArtist(String artistId) async {
  // Autentica en la API de Spotify si es necesario
  if (_accessToken == null) await _authenticate();

  // Realiza una petición GET para obtener información sobre el artista
  final response = await http.get(
    Uri.parse('$baseUrl/artists/$artistId'),
    headers: {'Authorization': 'Bearer $_accessToken'},
  );
  final data = jsonDecode(response.body);
  return data;
}

Future<Map<String, dynamic>> getArtistTopTracks(String artistId) async {
  // Autentica en la API de Spotify si es necesario
  if (_accessToken == null) await _authenticate();

  // Realiza una petición GET para obtener las canciones más populares del artista
  final response = await http.get(
    Uri.parse('$baseUrl/artists/$artistId/top-tracks?market=US'),
    headers: {'Authorization': 'Bearer $_accessToken'},
  );
  final data = jsonDecode(response.body);
  return data;
}

}
