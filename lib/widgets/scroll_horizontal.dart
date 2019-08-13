import 'package:filmapp/models/PeliculaModel.dart';
import 'package:filmapp/pages/DetallePelicula.dart';
import 'package:flutter/material.dart';

class ScrollHorizontal extends StatelessWidget {
  
  final List<Film> peliculas;
  final Function nextPage;


  //constructor
  ScrollHorizontal({@required this.peliculas, @required this.nextPage});

  final _pageController = new PageController(
          initialPage: 1,
          viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){

        if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){
          nextPage();
        }
    });
    
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(),
        itemCount: peliculas.length,
        itemBuilder: (context, i){
            return _cards(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _cards(BuildContext context, Film pelicula){
    final tarjeta = Container(
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

        return GestureDetector(
          child: tarjeta,
          onTap: (){
              Navigator.of(context).pushNamed('/detalle', arguments: pelicula);
          } ,
        );
  }

}
