class FavoriteCreationResponse {
  FavoriteCreationResponse({
    required this.slug,
    required this.userId,
  });

  final String? slug;
  final String? userId;

  factory FavoriteCreationResponse.fromJson(Map<String, dynamic> json){
    return FavoriteCreationResponse(
      slug: json["slug"],
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "user_id": userId,
  };

}