class BreadCrumb {
  BreadCrumb({
    required this.name,
    required this.slug,
    required this.isCurrent,
    required this.position,
  });

  final String? name;
  final String? slug;
  final bool? isCurrent;
  final int? position;

  factory BreadCrumb.fromJson(Map<String, dynamic> json){
    return BreadCrumb(
      name: json["name"],
      slug: json["slug"],
      isCurrent: json["isCurrent"],
      position: json["position"],
    );
  }

}