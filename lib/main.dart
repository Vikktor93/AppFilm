import 'package:filmapp/pages/DetallePelicula.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/Home.dart';
import 'pages/Login.dart';
import 'pages/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Film App",
      home: _mutaEstados(),
      initialRoute: '/',
      routes: {
        '/detalle' : (BuildContext context) => DetallePelicula(),
      },
    );
  }

  Widget _mutaEstados(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext cxt, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          return SplashScreen();
        else{
          if(snapshot.hasData){
            return Home();
          }
          return Login();
        }
      },
    );
  }

}