class SeoOnPage {
  SeoOnPage({
    required this.ogType,
    required this.titleHead,
    required this.descriptionHead,
    required this.ogImage,
    required this.ogUrl,
  });

  final String? ogType;
  final String? titleHead;
  final String? descriptionHead;
  final List<String> ogImage;
  final String? ogUrl;

  factory SeoOnPage.fromJson(Map<String, dynamic> json){
    return SeoOnPage(
      ogType: json["og_type"],
      titleHead: json["titleHead"],
      descriptionHead: json["descriptionHead"],
      ogImage: json["og_image"] == null ? [] : List<String>.from(json["og_image"]!.map((x) => x)),
      ogUrl: json["og_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "og_type": ogType,
    "titleHead": titleHead,
    "descriptionHead": descriptionHead,
    "og_image": ogImage.map((x) => x).toList(),
    "og_url": ogUrl,
  };

}
