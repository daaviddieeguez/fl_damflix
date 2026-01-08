import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [Text('Hola')]
            )
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

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
              'Titulo pelicula',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            )
          )
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://oracleoffilm.com/wp-content/uploads/1970/01/5-things-you-might-not-know-about-empire-strikes-back.jpg')
        ),
      ),
    );
  }
}

class _InfoPelicula extends StatelessWidget {
  const _InfoPelicula({super.key});

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
              image: NetworkImage('https://pics.filmaffinity.com/star_wars_episode_v_the_empire_strikes_back-701818523-large.jpg'),
              height: 150,
            ),
          ),
          Column(

          )
        ],
      ),
    );
  }
}