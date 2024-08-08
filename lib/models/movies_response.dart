import 'package:movie_stream/models/item.dart';
import 'package:movie_stream/models/paginate.dart';

class MoviesResponse {
  String? status;
  Paginate? paginate;
  List<Items>? items;

  MoviesResponse({this.status, this.paginate, this.items});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paginate = json['paginate'] != null
        ? new Paginate.fromJson(json['paginate'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.paginate != null) {
      data['paginate'] = this.paginate!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}