import 'dart:async';
import 'package:filmapp/models/PeliculaModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PeliculasProvider{
  
  String _apikey = '3b66a95e898d09c52902c237d5d9cdd0';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  List<Film> _populares = new List();

  final _popularesStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Film>> get popularesStream => _popularesStreamController.stream;


  //metodo para cerrar Stream, cuando ya no se usa (asi no crea multiple stream)
  void disposeStreams(){
    _popularesStreamController?.close();
  }

Future<List<Film>> _procesarRespuesta(Uri url) async {

      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);

      final peliculas = new Films.fromJsonList(decodedData['results']);

      return peliculas.items;
}

Future <List<Film>>getEnCines() async{

      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key' : _apikey,
        'language': _language
      });

      return await _procesarRespuesta(url);
  }


  Future <List<Film>>getPopulares() async{

    _popularesPage++;

      final url = Uri.https(_url, '3/movie/popular', {
        'api_key' : _apikey,
        'language': _language,
        'page'    : _popularesPage.toString()
      });

      final resp = await _procesarRespuesta(url);

      _populares.addAll(resp);
      popularesSink( _populares);

      return resp;

      
  }


}