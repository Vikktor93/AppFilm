import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../classes/Resultado.dart';

class Home extends StatefulWidget{

  HomeState createState(){
    return HomeState();
  }

}

class HomeState extends State<Home>{



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("MyIMDB"),
      ),
      body: FutureBuilder(
        future: webservice(),
        builder: (context, snapshot){
          if(snapshot.hasError)
            print(snapshot.error);
          if(snapshot.hasData)
            return lista(snapshot.data);
          return Center(child:CircularProgressIndicator());
        }
      )
    );
  }

  Future<List<Resultado>> webservice() async{
    final response = await http.get("http://www.omdbapi.com/?apikey=a0cbc18f&s=Star+Wars");

    if(response.statusCode!=200){
      print("Error en respuesta del servidor");
    }
    print("ANTES DE COMPUTAR");
    return compute(parseJson, response.body);

  }

  static List<Resultado> parseJson(String r){
    //print(r);
    final t = json.decode(r);
    
    var list = t['Search'] as List;
    
    return list.map<Resultado>((j)=>Resultado.fromJson(j)).toList();

  }

  Widget lista(List<Resultado> r){
    List<ListTile> l = List<ListTile>();

    for(num i=0; i<r.length; i+=1){
      l.add(
        ListTile(
          title: Text("${r[i].title}"),
          leading: Image.network("${r[i].poster}"),
        )
      );
    }
    return ListView(children: l);
  }


}