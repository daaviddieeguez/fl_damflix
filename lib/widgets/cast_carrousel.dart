import 'package:flutter/material.dart';

class CastCarrousel extends StatelessWidget {
  const CastCarrousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _CastCard();
        }
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          //Imagen actor
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://m.media-amazon.com/images/M/MV5BMTY4Mjg0NjIxOV5BMl5BanBnXkFtZTcwMTM2NTI3MQ@@._V1_FMjpg_UX1000_.jpg'),
              height: 100,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'actor.name Harrison Ford',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
