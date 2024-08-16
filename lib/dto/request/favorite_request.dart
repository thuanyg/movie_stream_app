class FavoriteRequest {
  FavoriteRequest({
    required this.userId,
    required this.slug,
    required this.name,
    required this.posterUrl,
    required this.quality,
    required this.language,
    required this.genres,
    required this.saveDate,
  });

  final String? userId;
  final String? slug;
  final String? name;
  final String? posterUrl;
  final String? quality;
  final String? language;
  final String? genres;
  final DateTime? saveDate;

  factory FavoriteRequest.fromJson(Map<String, dynamic> json){
    return FavoriteRequest(
      userId: json["user_id"],
      slug: json["slug"],
      name: json["name"],
      posterUrl: json["posterUrl"],
      quality: json["quality"],
      language: json["language"],
      genres: json["genres"],
      saveDate: DateTime.tryParse(json["save_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "slug": slug,
    "name": name,
    "quality": quality,
    "posterUrl": posterUrl,
    "language": language,
    "genres": genres,
    "save_date": saveDate?.toIso8601String(),
  };

}
