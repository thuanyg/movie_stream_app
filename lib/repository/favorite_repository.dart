import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/request/favorite_request.dart';
import 'package:movie_stream/dto/response/users/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie_stream/dto/response/users/favorite_creation_response.dart';
import 'package:movie_stream/dto/response/users/favorite_response.dart';
import 'package:movie_stream/utils/app_utils.dart';

class FavoriteRepository {
  final String URL = "$APP_BASE_URL/favorites";

  Future<ApiResponse<List<FavoriteResponse>>> fetchFavoriteMovies(
      String userid) async {
    String? token = await AppUtil.readSecureStorage(USER_TOKEN_KEY);
    try {
      final response = await http.get(
        Uri.parse('$URL/$userid'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );

      if (response.statusCode == 200) {
        // Giải mã nội dung phản hồi với mã hóa UTF-8
        final decodedBody = utf8.decode(response.bodyBytes);
        final rawData = json.decode(decodedBody);

        ApiResponse<List<FavoriteResponse>> parsedData =
            ApiResponse<List<FavoriteResponse>>.fromJson(
          rawData,
          (data) => List<FavoriteResponse>.from(
            (data as List).map(
              (item) => FavoriteResponse.fromJson(item),
            ),
          ),
        );

        return parsedData;
      } else {
        const errorMessage = 'Unknown error occurred. Please try again.';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponse<FavoriteCreationResponse>?> createFavoriteMovie(
      FavoriteRequest movie) async {
    try {
      final response = await http.post(
        Uri.parse(URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(movie.toJson()),
      );
      if (response.statusCode == 200) {
        ApiResponse<FavoriteCreationResponse> rawData =
            ApiResponse<FavoriteCreationResponse>.fromJson(
          json.decode(response.body),
          (data) => FavoriteCreationResponse.fromJson(data),
        );
        return rawData;
      }

      return null;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<ApiResponse<String>?> deleteFavoriteMovie(int favID) async {
    String? token = await AppUtil.readSecureStorage(USER_TOKEN_KEY);
    try {
      final response = await http.delete(
        Uri.parse('$URL/$favID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ApiResponse<String>? apiResponse = ApiResponse.fromJson(data, (json) => json ?? "");
        return apiResponse;
      } else {
        return null;
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
