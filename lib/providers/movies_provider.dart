import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

String _apiKey = 'f13f15ad46ff8743695b6f4ab37a82c7';
String _baseUrl = 'api.themoviedb.org';
String _languaje = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider ha sido inicializado');

    this.getOnDisplayMovies();

  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '1'
    }   
    );
    var response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode( response.body );

    print( decodeData['results'][4] );
  }
}