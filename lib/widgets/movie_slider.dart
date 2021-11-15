import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    /* metodo para realizar el infinite scroll  */
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.isEmpty) {
      //valida si no hay peliculas retorne una barra en progreso mientras carga
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      //en el video fernando usa container para poder colorear el container, luego lo quita y cambia a sizedbox
      width: double.infinity,
      height: 265,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, //indicamos que la columna tiene una alineacion a la izquierda
        //es una columna porque necesita crear widgets uno encima de otro
        children: [
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            /* Con el expanded, el ListView toma todo el tamaño posible 
            que hereda de su padre, en este caso el container */
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis
                  .horizontal, //indicamos que necesitamos el scroll horizontal
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MovieSlider(widget.movies[index],
                  '${widget.title}-${index}-${widget.movies[index].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MovieSlider(this.movie, this.heroId);

  /* con este widget estamos construyendo cada cajita verde,
   el contenido de cada recuadro o container */
  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments:
                    movie), //este gesture me sirve para que al darle click se abra una nueva ventana en este caso details
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  //fue lo que primero cree, luego lo encerre en el cliprrect para usar el border
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit
                      .cover, //La imagen se expande todo lo que pueda sin perder sus caract4eristicas
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            movie.title,
            maxLines: 2, //cantidad de sobre linea que puede tener el texto
            overflow:
                TextOverflow.ellipsis, //indica con ... que hay mas contenido
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
