import 'package:movie_stream/dto/response/movies/server_datum.dart';

class Episode {
  Episode({
    required this.serverName,
    required this.serverData,
  });

  final String serverName;
  final List<ServerDatum> serverData;

  factory Episode.fromJson(Map<String, dynamic> json){
    return Episode(
      serverName: json["server_name"],
      serverData: json["server_data"] == null ? [] : List<ServerDatum>.from(json["server_data"]!.map((x) => ServerDatum.fromJson(x))),
    );
  }

}
