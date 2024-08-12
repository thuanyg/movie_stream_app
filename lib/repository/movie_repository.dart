import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/response/movies/latest_movie_response.dart';
import 'package:movie_stream/networks/status_code.dart';

class MovieRepository {
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
        throw Exception('Failed to load latest movies: status code ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
