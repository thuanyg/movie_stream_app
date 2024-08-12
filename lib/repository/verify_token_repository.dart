import 'dart:convert';
import 'dart:io';

import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/response/api_response.dart';
import 'package:movie_stream/dto/response/verify_token_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie_stream/networks/exception/http_exception.dart';
import 'package:movie_stream/networks/status_code.dart';

class VerifyRepository {
  Future<ApiResponse<VerifyTokenResponse>> verifyToken(String token) async {

    const String url = '$APP_BASE_URL/auth/verify';

    Map<String, dynamic> body = {"token": token};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      final data = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          return ApiResponse<VerifyTokenResponse>.fromJson(
            data,
            (json) => VerifyTokenResponse.fromJson(json),
          );
        case 400:
          final errorMessage =
              data['message'] ?? 'Bad Request. Please check your input.';
          throw BadRequestException(errorMessage);
        case 500:
          final errorMessage = data['message'] ??
              'Internal Server Error. Please try again later.';
          throw InternalServerException(errorMessage);
        default:
          final errorMessage =
              data['message'] ?? 'Unknown error occurred. Please try again.';
          throw Exception(errorMessage);
      }
    } on SocketException catch (e) {
      throw Exception(e.message);
    }
  }
}
