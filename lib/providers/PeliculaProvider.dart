import 'package:filmapp/models/PeliculaModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PeliculasProvider{
  
  String _apikey = '3b66a95e898d09c52902c237d5d9cdd0';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

Future <List<Film>>getEnCines() async{

      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key' : _apikey,
        'language': _language
      });

      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);

      final peliculas = new Films.fromJsonList(decodedData['results']);

      return peliculas.items;
  }


}