import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = //nos permite tomar el texto de la pelicula
        ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        /* usamos customScroll porque se necesita que la pagina se pueda 
      hacer scroll. Cuando se hace scroll hasta abajo el header no se pierde */
        slivers: [
          //se pueden cargar widgets de tipo sliver
          _CustomAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie),
                _SeccionText(movie),
                _SeccionText(movie),
                _SeccionText(movie),
                ActorsCards(movie.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//creamos el appbar
class _CustomAppbar extends StatelessWidget {
  final Movie movie; //asignamos el objeto movie a la variable movie

  const _CustomAppbar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, // para que nunca desaparezxca el appbar al hacer scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding:
            EdgeInsets.all(0), //elimina el pading que se crea abajo del texto
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//creamos la carta y el titulo de la pelicula
class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        //creamos la tarjeta
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                  movie.fullPosterImg,
                ),
                height: 160,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          //creamos la columna que contentra la informacion de la derecha de la tarjeta
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: size.width -
                    190), //decimos que puede tomar todo el ancho y si se pasa lo pase debajo
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headline6,
                  //llama la variable textTheme creada al inicio
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme
                      .subtitle1, //llama la variable textTheme creada al inicio
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  //creamos un row de nuevo porque necesitaremos varias cosas en el mismo lugar
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(movie.voteAverage.toString(),
                        style: textTheme
                            .caption), //llama la variable textTheme creada al inicio                 )
                  ],
                )
                //estilo que aplicamos al texto
              ],
            ),
          )
        ],
      ),
    );
  }
}

//creamos container para el texto de la pelicula
class _SeccionText extends StatelessWidget {
  final Movie movie;
  const _SeccionText(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
