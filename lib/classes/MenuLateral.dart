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
                    title: Text("Menu 1", style: TextStyle(color: Colors.white),),
                    onTap: (){},
                ),
              ),
              
              new ListTile(
                title: Text("Menu 2"),
              ),

              new ListTile(
                title: Text("Menu 2"),
              )
            ],
          ),
      );
    }
}