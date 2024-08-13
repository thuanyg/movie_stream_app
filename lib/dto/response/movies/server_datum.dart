class ServerDatum {
  ServerDatum({
    required this.name,
    required this.slug,
    required this.filename,
    required this.linkEmbed,
    required this.linkM3U8,
  });

  final String name;
  final String slug;
  final String filename;
  final String linkEmbed;
  final String linkM3U8;

  factory ServerDatum.fromJson(Map<String, dynamic> json){
    return ServerDatum(
      name: json["name"],
      slug: json["slug"],
      filename: json["filename"],
      linkEmbed: json["link_embed"],
      linkM3U8: json["link_m3u8"],
    );
  }

}