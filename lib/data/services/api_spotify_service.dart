import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

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
      Uri.parse('$baseUrl/playlists/$playlistId/tracks?limit=6'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    final tracksData = jsonDecode(tracksResponse.body);

    // Extrae los datos de los álbumes de las canciones
    final albums =
        tracksData['items'].map((item) => item['track']['album']).toList();

    // Devuelve los datos de los álbumes
    return List<Map<String, dynamic>>.from(albums);
  }

  // Método para obtener los artistas más populares
  Future<List<Map<String, dynamic>>> getPopularArtists() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Obtiene el año actual
    final int currentYear = DateTime.now().year;

    // Realiza una petición GET para buscar artistas populares del año actual
    final response = await http.get(
      Uri.parse('$baseUrl/search?q=year:$currentYear&type=artist&limit=6'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de los artistas
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['artists']['items']);
  }

  // Método para obtener las canciones más populares
  Future<List<Map<String, dynamic>>> getPopularSongs() async {
    // Autentica en la API de Spotify si es necesario
    if (_accessToken == null) await _authenticate();

    // Realiza una petición GET para obtener las canciones más populares
    final response = await http.get(
      Uri.parse('$baseUrl/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks?limit=6'),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    // Decodifica la respuesta y devuelve los datos de las canciones
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['items']);
  }

  Future<List<Map<String, dynamic>>> getTopPlaylists() async {
  // Autentica en la API de Spotify si es necesario
  if (_accessToken == null) await _authenticate();

  // Realiza una petición GET para obtener las playlists más populares de Estados Unidos
  final response = await http.get(
    Uri.parse('$baseUrl/browse/categories/toplists/playlists?country=US&limit=6'),
    headers: {'Authorization': 'Bearer $_accessToken'},
  );

  // Decodifica la respuesta y devuelve los datos de las playlists
  final data = jsonDecode(response.body);
  return List<Map<String, dynamic>>.from(data['playlists']['items']);
}

}
