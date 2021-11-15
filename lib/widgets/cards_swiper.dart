import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    /* Importante, debemos importar la libreria flutter_card_swipper: ^0.4.0
    debemos pegar ese contenido en el pubspec.yaml debajo de cupertino_icons
    esto nos permitira usar la animacion de las cartas.
    
    asi mismo importamos las imagenes que ocupamos en el pubspec.yaml 
    apartado assets, agregamos -assets/ respetando los saltos de linea y espaciado*/

    return SizedBox(
      //creamos un container para alojar las cartas
      width: double.infinity, //ancho completo
      height: size.height * 0.5, // toma el 50% de la pantalla

      child: Swiper(
        //el Swiper lo hacemos importando la libreria flutter_card_swipper: ^0.4.0
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          //construye las cartas

          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';

          return GestureDetector(
            //permite que al dar click sobre la primera imagen, se dirija a la pantalla details_screen
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
