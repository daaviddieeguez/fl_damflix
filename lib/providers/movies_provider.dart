import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_damflix/models/models.dart';

class MoviesProvider extends ChangeNotifier{

final String _apiKey = 'f13f15ad46ff8743695b6f4ab37a82c7';
final String _baseUrl = 'api.themoviedb.org';
final String _languaje = 'es-ES';

List<Result> onDisplayMovies = [];
List<Result> popularMovies = [];
Map<int, List<Video>> moviesVideos = {};

  MoviesProvider() {
    print('MoviesProvider ha sido inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '1'
    }   
    );
    var response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '1'
    }   
    );
    var response = await http.get(url);

    final popularResponse = PopularResponse.fromJson(response.body);
    
    popularMovies = popularResponse.results;

    notifyListeners();
  }

  // Importante: Cambia el retorno a Future<List<Video>>
  // Asegúrate de importar tu modelo: import 'package:fl_damflix/models/models.dart';

  Future<List<Video>> getMovieVideos(int movieId) async {
    
    // 1. Optimización: Comprobar caché (para no gastar datos a lo tonto)
    if (moviesVideos.containsKey(movieId)) {
      return moviesVideos[movieId]!;
    }

    print('Pidiendo videos para la peli: $movieId');

    // 2. Construcción de URL
    var url = Uri.https(_baseUrl, '/3/movie/$movieId/videos', {
      'api_key': _apiKey,
      'language': _languaje, // Ojo: a veces los trailers solo están en inglés ('en-US')
    });

    // 3. Petición HTTP
    final response = await http.get(url);

    // 4. Mapeo usando TU clase nueva
    final videosResponse = VideosResponse.fromJson(response.body);
    
    // 5. Guardar en mapa (Caché)
    // Guardamos la lista completa de resultados
    moviesVideos[movieId] = videosResponse.results;

    return videosResponse.results;
  }
}