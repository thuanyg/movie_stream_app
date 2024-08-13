import 'package:movie_stream/dto/response/movie_by_genre/category.dart';
import 'package:movie_stream/dto/response/movies/created.dart';

class Movie {
  Movie({
    required this.created,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.content,
    required this.type,
    required this.status,
    required this.posterUrl,
    required this.thumbUrl,
    required this.isCopyright,
    required this.subDocquyen,
    required this.chieurap,
    required this.trailerUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.notify,
    required this.showtimes,
    required this.year,
    required this.view,
    required this.actor,
    required this.director,
    required this.category,
    required this.country,
  });

  final Created created;
  final Created modified;
  final String id;
  final String name;
  final String slug;
  final String originName;
  final String content;
  final String type;
  final String status;
  final String posterUrl;
  final String thumbUrl;
  final bool isCopyright;
  final bool subDocquyen;
  final bool chieurap;
  final String trailerUrl;
  final String time;
  final String episodeCurrent;
  final String episodeTotal;
  final String quality;
  final String lang;
  final String notify;
  final String showtimes;
  final int year;
  final int view;
  final List<String> actor;
  final List<String> director;
  final List<Category> category;
  final List<Category> country;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      created: json["created"] = Created.fromJson(json["created"]),
      modified: json["modified"] = Created.fromJson(json["modified"]),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      originName: json["origin_name"],
      content: json["content"],
      type: json["type"],
      status: json["status"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      isCopyright: json["is_copyright"],
      subDocquyen: json["sub_docquyen"],
      chieurap: json["chieurap"],
      trailerUrl: json["trailer_url"],
      time: json["time"],
      episodeCurrent: json["episode_current"],
      episodeTotal: json["episode_total"],
      quality: json["quality"],
      lang: json["lang"],
      notify: json["notify"],
      showtimes: json["showtimes"],
      year: json["year"],
      view: json["view"],
      actor: json["actor"] == null
          ? []
          : List<String>.from(json["actor"]!.map((x) => x)),
      director: json["director"] == null
          ? []
          : List<String>.from(json["director"]!.map((x) => x)),
      category: json["category"] == null
          ? []
          : List<Category>.from(
              json["category"]!.map((x) => Category.fromJson(x))),
      country: json["country"] == null
          ? []
          : List<Category>.from(
              json["country"]!.map((x) => Category.fromJson(x))),
    );
  }
}
