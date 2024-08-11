import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/request/user_creation_request.dart';
import 'package:movie_stream/dto/response/api_response.dart';
import 'package:movie_stream/dto/response/user_creation_response.dart';
import 'package:movie_stream/models/user.dart';
import 'package:movie_stream/networks/exception/http_exception.dart';
import 'package:movie_stream/repository/repository.dart';

class UserRepository
    extends Repository<User, UserCreationRequest, UserCreationRequest> {
  @override
  Future<ApiResponse<dynamic>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<dynamic>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<UserCreationResponse>> post(
      UserCreationRequest userRequest) async {
    const url = '$APP_BASE_URL/users';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userRequest.toJson()),
      );
      // Xu ly exception
      final data = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          return ApiResponse<UserCreationResponse>.fromJson(
              data, (json) => UserCreationResponse.fromJson(json));
        case 400:
          final errorMessage = data['message'] ?? 'Bad Request. Please check your input.';
          throw BadRequestException(errorMessage);
        case 500:
          final errorMessage = data['message'] ?? 'Internal Server Error. Please try again later.';
          throw InternalServerException(errorMessage);
        default:
          final errorMessage = data['message'] ?? 'Unknown error occurred. Please try again.';
          throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<dynamic>> update(String id, UserCreationRequest t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
