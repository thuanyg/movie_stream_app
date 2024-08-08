class Items {
  String? name;
  String? slug;
  String? originalName;
  String? thumbUrl;
  String? posterUrl;
  String? created;
  String? modified;
  String? description;
  int? totalEpisodes;
  String? currentEpisode;
  String? time;
  String? quality;
  String? language;
  String? director;
  String? casts;

  Items(
      {this.name,
        this.slug,
        this.originalName,
        this.thumbUrl,
        this.posterUrl,
        this.created,
        this.modified,
        this.description,
        this.totalEpisodes,
        this.currentEpisode,
        this.time,
        this.quality,
        this.language,
        this.director,
        this.casts});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    originalName = json['original_name'];
    thumbUrl = json['thumb_url'];
    posterUrl = json['poster_url'];
    created = json['created'];
    modified = json['modified'];
    description = json['description'];
    totalEpisodes = json['total_episodes'];
    currentEpisode = json['current_episode'];
    time = json['time'];
    quality = json['quality'];
    language = json['language'];
    director = json['director'];
    casts = json['casts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['original_name'] = this.originalName;
    data['thumb_url'] = this.thumbUrl;
    data['poster_url'] = this.posterUrl;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['description'] = this.description;
    data['total_episodes'] = this.totalEpisodes;
    data['current_episode'] = this.currentEpisode;
    data['time'] = this.time;
    data['quality'] = this.quality;
    data['language'] = this.language;
    data['director'] = this.director;
    data['casts'] = this.casts;
    return data;
  }
}