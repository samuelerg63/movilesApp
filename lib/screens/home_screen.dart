import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(
        context); //obtiene la instancia de movies provider

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(context: context, delegate: MovieSearchDelegate());
                }), //muestra la lupita
          ],
        ),
        body: SingleChildScrollView(
          //permite hacer scroll hacia abajo
          child: Column(
            children: [
              //tarjetas principales
              CardSwiper(
                movies: moviesProvider.onDisplayMovie,
              ), //llamamos el widget creado en /widget/cards_swiper.dart
              //slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPage: () {
                  moviesProvider.getPopularMovies();
                },
              ),
            ],
          ),
        ));
  }
}
