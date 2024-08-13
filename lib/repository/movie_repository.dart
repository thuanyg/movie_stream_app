import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/response/movie_by_genre/api_response.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/dto/response/movies/latest_movie_response.dart';
import 'package:movie_stream/networks/status_code.dart';

class MovieRepository {
  // Get latest movies
  Future<LatestMovieResponse> fetchLatestMovie(int page) async {
    final String endPoint = 'danh-sach/phim-moi-cap-nhat?page=$page';
    final String url = '$MOVIE_API_URL/$endPoint';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatusCode.OK.code) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Convert JSON to LatestMovieResponse object
        return LatestMovieResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to load latest movies: status code ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Get list movie by genre
  Future<MovieByGenreResponse> fetchMoviesByGenre(
      String genre, int page) async {
    final String endPoint = '/v1/api/danh-sach/${genre}?page=$page';
    final String url = '$MOVIE_API_URL/$endPoint';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatusCode.OK.code) {
        final data = json.decode(response.body);
        MovieByGenreResponse dataObj = MovieByGenreResponse.fromJson(data);
        return dataObj;
      }
      throw Exception(
          'Failed to load latest movies: status code ${response.statusCode}');
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Get movie detail
  Future<MovieDetail> getMovieDetail(String slug) async {
    final String endPoint = '/phim/$slug';
    final String url = '$MOVIE_API_URL/$endPoint';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatusCode.OK.code) {
        final data = json.decode(response.body);
        MovieDetail movieDetailObj = MovieDetail.fromJson(data);
        return movieDetailObj;
      }
      throw Exception(
          'Failed to load latest movies: status code ${response.statusCode}');
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
