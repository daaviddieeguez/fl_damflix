import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{
  MoviesProvider(){
    print('MoviesProvider ha sido inicializado');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async{
    print('getOnDisplayMovies');
  }
  
}