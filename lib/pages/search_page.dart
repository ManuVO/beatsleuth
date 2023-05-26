import 'package:flutter/material.dart';
import 'package:beatsleuth/data/services/api_spotify_service.dart';

class SearchPage extends StatefulWidget {
  final SearchPageData data;
  const SearchPage({Key? key, required this.data}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class SearchPageData {
  List<Map<String, dynamic>> playlists = [];
}

class _SearchPageState extends State<SearchPage> {
  // Instancia del servicio de Spotify
  final SpotifyService _spotifyService = SpotifyService();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _playlists = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlaylists() async {
    if (widget.data.playlists.isNotEmpty) {
      _playlists = widget.data.playlists;
    } else {
      final playlists = await _spotifyService.getTopPlaylists();
      setState(() {
        widget.data.playlists = playlists;
        _playlists = widget.data.playlists;
      });
    }
  }

  void _onSearchChanged() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _showSearchResults = false;
      });
    } else {
      final results = await _spotifyService.search(_searchController.text);
      setState(() {
        _searchResults = results;
        _showSearchResults = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Buscar',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '¿Qué tipo de canciones te gustaría encontrar?',
              ),
              controller: _searchController,
            ),
          ),
          Visibility(
            visible: !_showSearchResults,
            child: Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Disfruta de las mejores playlist',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 4.0),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: _playlists.length,
                          itemBuilder: (context, index) {
                            final playlist = _playlists[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 16.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      playlist['images'][0]['url'],
                                      width: 125,
                                      height: 125,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Flexible(
                                    child: Text(
                                      playlist['name'],
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _showSearchResults,
            child: Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 4.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    String imageUrl = '';
                    String title = '';
                    String subtitle = '';
                    if (result['type'] == 'track') {
                      if (result['album']['images'].isNotEmpty) {
                        imageUrl = result['album']['images'][0]['url'];
                      }
                      title = result['name'];
                      subtitle = result['artists'][0]['name'];
                    } else if (result['type'] == 'album') {
                      if (result['images'].isNotEmpty) {
                        imageUrl = result['images'][0]['url'];
                      }
                      title = result['name'];
                      subtitle = 'Album - ${result['artists'][0]['name']}';
                    } else if (result['type'] == 'artist') {
                      if (result['images'].isNotEmpty) {
                        imageUrl = result['images'][0]['url'];
                      }
                      title = result['name'];
                    }
                    if (imageUrl.isEmpty) {
                      return SizedBox();
                    } else {
                      return ListTile(
                        leading: Image.network(imageUrl),
                        title: Text(title),
                        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
