import 'package:flutter/material.dart';


class MenuLateral extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
      return new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text("Victor Saldivia"),
                accountEmail: Text("viktorsaldivia93@gmail.com"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://www.saga.co.uk/contentlibrary/saga/publishing/verticals/entertainment/films-and-tv/films_tv-hero-1260x600.jpg"),
                    fit: BoxFit.cover
                  )
                ),
              ),

              Ink(
                color: Colors.redAccent[400],
                child: new ListTile(
                    title: Text("Home", style: TextStyle(color: Colors.white),),
                    onTap: (){},
                ),
              ),

              SizedBox(height: 1.0),
              
              Ink(
                color: Colors.redAccent[400],
                child: new ListTile(
                    title: Text("Mejor Valoradas", style: TextStyle(color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Valoradas()
                          )
                      );
                    },
                ),
              ),

              SizedBox(height: 1.0),

              Ink(
                color: Colors.redAccent[400],
                child: new ListTile(
                    title: Text("Favoritas", style: TextStyle(color: Colors.white),),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                ),
              ),
              SizedBox(height: 220.0),

              Divider(),

              Ink(
                color: Colors.redAccent[400],
                child: new ListTile(
                    title: Text("Logout", style: TextStyle(color: Colors.white),),
                    onTap: (){

        
                     
                    },
                ),
              ),
            ],
          ),
      );
    }
}

class Valoradas extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: AppBar(
        title: Text('App Film'),
        backgroundColor: Colors.redAccent[400],
    ),

    body: Center(
      child: Text("Mejor Valoradas"),
    ),
    );
  }
}