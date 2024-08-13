import 'package:movie_stream/dto/response/movies/episode.dart';
import 'package:movie_stream/dto/response/movies/movie.dart';

class MovieDetail {
  MovieDetail({
    required this.status,
    required this.msg,
    required this.movie,
    required this.episodes,
  });

  final bool? status;
  final String? msg;
  final Movie movie;
  final List<Episode> episodes;

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      status: json["status"],
      msg: json["msg"],
      movie: json["movie"] = Movie.fromJson(json["movie"]),
      episodes: json["episodes"] == null
          ? []
          : List<Episode>.from(
              json["episodes"]!.map((x) => Episode.fromJson(x))),
    );
  }
}
