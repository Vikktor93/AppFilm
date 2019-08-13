import 'package:filmapp/models/PeliculaModel.dart';
import 'package:flutter/material.dart';

class ScrollHorizontal extends StatelessWidget {
  
  final List<Film> peliculas;

  //constructor
  ScrollHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _tarjetas(),
      ),
    );
  }

  List<Widget> _tarjetas(){

      return peliculas.map((pelicula){

        return Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              )
            ],
          ),

        );
      }).toList();


  }
}
