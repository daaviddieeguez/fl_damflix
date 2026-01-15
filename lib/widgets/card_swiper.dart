import 'package:card_swiper/card_swiper.dart';
import 'package:fl_damflix/models/models.dart';
import 'package:flutter/material.dart';


class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.movies});

  final List<Result> movies;

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    if( this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.yellow,
      padding: const EdgeInsets.all(25),
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * 0.9,
        itemWidth: size.width * 0.6,
        itemBuilder: (context, index) {
          
          final movie = movies[index];
          print( movie.posterPath );

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover
              ),
            ),
          );
        },
      ),

    );
  }
}