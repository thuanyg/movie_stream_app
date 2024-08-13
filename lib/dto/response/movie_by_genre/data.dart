import 'package:movie_stream/dto/response/movie_by_genre/BreadCrumb.dart';
import 'package:movie_stream/dto/response/movie_by_genre/SeoOnPage.dart';
import 'package:movie_stream/dto/response/movie_by_genre/items.dart';
import 'package:movie_stream/dto/response/movie_by_genre/params.dart';

class Data {
  Data({
    required this.seoOnPage,
    required this.breadCrumb,
    required this.titlePage,
    required this.items,
    required this.params,
    required this.typeList,
    required this.appDomainFrontend,
    required this.appDomainCdnImage,
  });

  final SeoOnPage? seoOnPage;
  final List<BreadCrumb> breadCrumb;
  final String? titlePage;
  final List<Item> items;
  final Params? params;
  final String? typeList;
  final String? appDomainFrontend;
  final String? appDomainCdnImage;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      seoOnPage: json["seoOnPage"] == null ? null : SeoOnPage.fromJson(json["seoOnPage"]),
      breadCrumb: json["breadCrumb"] == null ? [] : List<BreadCrumb>.from(json["breadCrumb"]!.map((x) => BreadCrumb.fromJson(x))),
      titlePage: json["titlePage"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      params: json["params"] == null ? null : Params.fromJson(json["params"]),
      typeList: json["type_list"],
      appDomainFrontend: json["APP_DOMAIN_FRONTEND"],
      appDomainCdnImage: json["APP_DOMAIN_CDN_IMAGE"],
    );
  }

}