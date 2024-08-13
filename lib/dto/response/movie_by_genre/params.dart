import 'package:movie_stream/models/pagination.dart';

class Params {
  Params({
    required this.typeSlug,
    required this.filterCategory,
    required this.filterCountry,
    required this.filterYear,
    required this.filterType,
    required this.sortField,
    required this.sortType,
    required this.pagination,
  });

  final String? typeSlug;
  final List<String> filterCategory;
  final List<String> filterCountry;
  final String? filterYear;
  final String? filterType;
  final String? sortField;
  final String? sortType;
  final Pagination? pagination;

  factory Params.fromJson(Map<String, dynamic> json){
    return Params(
      typeSlug: json["type_slug"],
      filterCategory: json["filterCategory"] == null ? [] : List<String>.from(json["filterCategory"]!.map((x) => x)),
      filterCountry: json["filterCountry"] == null ? [] : List<String>.from(json["filterCountry"]!.map((x) => x)),
      filterYear: json["filterYear"],
      filterType: json["filterType"],
      sortField: json["sortField"],
      sortType: json["sortType"],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}