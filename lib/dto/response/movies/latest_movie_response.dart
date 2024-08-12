import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/models/pagination.dart';

class LatestMovieResponse {
  bool? status;
  List<ItemsLatestMovie>? items;
  Pagination? pagination;

  LatestMovieResponse({this.status, this.items, this.pagination});

  LatestMovieResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['items'] != null) {
      items = <ItemsLatestMovie>[];
      json['items'].forEach((v) {
        items!.add(new ItemsLatestMovie.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}