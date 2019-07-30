
class Resultado{

  String title;
  String year;
  String id;
  String type;
  String poster;

  Resultado({this.title,this.year,this.id,this.type,this.poster});

  factory Resultado.fromJson(Map<String, dynamic> json){
    return Resultado(
      title : json['Title'] as String,
      year : json['Year'] as String,
      id : json['imdbID'] as String,
      type : json['Type'] as String,
      poster : json['Poster'] as String
    );
  }

}