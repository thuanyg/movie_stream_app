import 'package:movie_stream/dto/response/movie_by_genre/category.dart';
import 'package:movie_stream/models/modified.dart';

class Item {
  Item({
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.type,
    required this.posterUrl,
    required this.thumbUrl,
    required this.subDocquyen,
    required this.chieurap,
    required this.time,
    required this.episodeCurrent,
    required this.quality,
    required this.lang,
    required this.year,
    required this.category,
    required this.country,
  });

  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? type;
  final String? posterUrl;
  final String? thumbUrl;
  final bool? subDocquyen;
  final bool? chieurap;
  final String? time;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final int? year;
  final List<Category> category;
  final List<Category> country;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      modified: json["modified"] == null ? null : Modified.fromJson(json["modified"]),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      originName: json["origin_name"],
      type: json["type"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      subDocquyen: json["sub_docquyen"],
      chieurap: json["chieurap"],
      time: json["time"],
      episodeCurrent: json["episode_current"],
      quality: json["quality"],
      lang: json["lang"],
      year: json["year"],
      category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
      country: json["country"] == null ? [] : List<Category>.from(json["country"]!.map((x) => Category.fromJson(x))),
    );
  }

}