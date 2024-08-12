import 'package:movie_stream/models/modified.dart';

class ItemsLatestMovie {
  Modified? modified;
  String? sId;
  String? name;
  String? slug;
  String? originName;
  String? posterUrl;
  String? thumbUrl;
  int? year;

  ItemsLatestMovie(
      {this.modified,
      this.sId,
      this.name,
      this.slug,
      this.originName,
      this.posterUrl,
      this.thumbUrl,
      this.year});

  ItemsLatestMovie.fromJson(Map<String, dynamic> json) {
    modified = json['modified'] != null
        ? new Modified.fromJson(json['modified'])
        : null;
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    originName = json['origin_name'];
    posterUrl = json['poster_url'];
    thumbUrl = json['thumb_url'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (modified != null) {
      data['modified'] = modified!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['origin_name'] = originName;
    data['poster_url'] = posterUrl;
    data['thumb_url'] = thumbUrl;
    data['year'] = year;
    return data;
  }
}
