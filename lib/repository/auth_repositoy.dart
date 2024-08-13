import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/request/auth_request.dart';
import 'package:movie_stream/dto/response/users/api_response.dart';
import 'package:movie_stream/dto/response/users/auth_response.dart';
import 'package:movie_stream/models/user.dart';
import 'package:movie_stream/networks/exception/http_exception.dart';
import 'package:movie_stream/repository/repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends Repository<User, AuthRequest, Object> {
  @override
  Future<ApiResponse> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<AuthResponse>> post(AuthRequest t) async {
    const url = '$APP_BASE_URL/auth';
    try {
      Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(t.toJson()),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );;

      final data = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          return ApiResponse<AuthResponse>.fromJson(
            data,
            (json) => AuthResponse.fromJson(json),
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

  @override
  Future<ApiResponse> update(String id, t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
}
