import 'package:movie_stream/dto/response/movie_by_genre/data.dart';

class MovieByGenreResponse {
  MovieByGenreResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  final String? status;
  final String? msg;
  final Data? data;

  factory MovieByGenreResponse.fromJson(Map<String, dynamic> json){
    return MovieByGenreResponse(
      status: json["status"],
      msg: json["msg"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}