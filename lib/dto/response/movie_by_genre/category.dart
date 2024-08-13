class Category {
  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  final String? id;
  final String? name;
  final String? slug;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
    );
  }

}