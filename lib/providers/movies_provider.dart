import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_damflix/models/models.dart';

class MoviesProvider extends ChangeNotifier{

final String _apiKey = 'f13f15ad46ff8743695b6f4ab37a82c7';
final String _baseUrl = 'api.themoviedb.org';
final String _languaje = 'es-ES';

List<Result> onDisplayMovies = [];
List<Result> popularMovies = [];

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
}