import 'package:filmapp/providers/PeliculaProvider.dart';
import 'package:filmapp/widgets/scroll_horizontal.dart';
import 'package:filmapp/widgets/swiper.dart';
import 'package:flutter/material.dart';
import '../classes/MenuLateral.dart';

class Home extends StatelessWidget {

  final peliculasprovider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Film'),
        backgroundColor: Colors.redAccent[400],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),

        ],
      ),
     
     drawer: MenuLateral(),
     body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
            _swiperTargetas(),
            _footer(context)
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

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
             padding: EdgeInsets.only(top: 12.0, left: 20.0),
             child: Text('Peliculas Populares', style: Theme.of(context).textTheme.subhead),
          ),

          SizedBox(height: 10.0),

          FutureBuilder(
            future: peliculasprovider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              snapshot.data?.forEach( (p)=>(p.title));
              
              if(snapshot.hasData){
                return ScrollHorizontal(peliculas: snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              } 
            },
          ),
        ],
      ),
    );
  }
}

 