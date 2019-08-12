import 'package:filmapp/providers/PeliculaProvider.dart';
import 'package:filmapp/widgets/swiper.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final peliculasprovider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Film'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),

          IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {},
          ),
        ],
      ),
     
     body: Container(
      child: Column(
        children: <Widget>[
            _swiperTargetas()
        ],
      ),
     ),
      
    );
  }


  Widget _swiperTargetas(){

   
   peliculasprovider.getEnCines();
   
   return FutureBuilder(
     future: peliculasprovider.getEnCines(),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

       if(snapshot.hasData){
         return CardSwiper(
         peliculas: snapshot.data);
       }else{
         return Container(
           height: 400.0,
           child: Center(
             child: CircularProgressIndicator()
             ) 
           );
       }
     },
   );
  }
}


