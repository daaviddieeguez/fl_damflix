import 'package:fl_damflix/models/models.dart';
import 'package:fl_damflix/providers/movies_provider.dart';
import 'package:fl_damflix/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Result movie = ModalRoute.of(context)!.settings.arguments as Result;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _InfoPelicula(movie: movie),
              _Overview(movie: movie),
              CastCarrousel(),
              _TrailerButton(movieId: movie.id)
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({required this.movie});

  final Result movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          //color: Colors.white54,
          child: Container(
            width: double.infinity,
            color: Colors.white54,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
        ),
      ),
    );
  }
}

class _InfoPelicula extends StatelessWidget {
  const _InfoPelicula({required this.movie});

  final Result movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.releaseDate.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                Row(
                  children: [
                    Icon(Icons.star_rate_sharp, size: 30, color: Colors.orange),
                    Text(
                      movie.voteAverage.toString().substring(0, 3),
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.movie});

  final Result movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(movie.overview, textAlign: TextAlign.justify),
    );
  }
}

class _TrailerButton extends StatelessWidget {
  final int movieId;

  const _TrailerButton({required this.movieId});

  @override
  Widget build(BuildContext context) {
    // 1. Obtenemos el provider (listen: false porque está dentro de un FutureBuilder y no necesitamos redibujar por notificaciones)
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieVideos(movieId),
      builder: (_, AsyncSnapshot<List<Video>> snapshot) {
        
        // Mientras carga, mostramos un indicador pequeño o nada
        if (!snapshot.hasData) {
          return Container(
            height: 50,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final videos = snapshot.data!;
        
        // 2. Lógica de Backend en el Frontend: Buscar el trailer correcto
        // Intentamos buscar uno que sea de YouTube y tipo 'Trailer'
        // Si no, cogemos el primero que haya.
        final videoHtml = videos.firstWhere(
            (video) => video.site == 'YouTube' && video.type == 'Trailer',
            orElse: () => Video(
                iso6391: '', iso31661: '', name: 'No trailer', 
                key: '', site: '', size: 0, type: '', 
                official: false, publishedAt: DateTime.now(), id: '')
        );
        
        // Si la key está vacía, es que no encontró nada válido
        if (videoHtml.key.isEmpty) {
          return SizedBox(); // No mostramos nada si no hay video
        }

        return Container(
          margin: EdgeInsets.only(top: 20, bottom: 0),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // AQUÍ LA ACCIÓN
              print('Reproducir video ID: ${videoHtml.key}');
              // Más adelante aquí usarás url_launcher para abrir YouTube:
              // launchUrl(Uri.parse('https://www.youtube.com/watch?v=${videoHtml.key}'));
            },
            icon: Icon(Icons.play_circle_fill_outlined, size: 30),
            label: Text('Ver Tráiler', style: TextStyle(fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade900, // Color rojo YouTube
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        );
      },
    );
  }
}