import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/dto/request/user_creation_request.dart';
import 'package:movie_stream/networks/exception/http_exception.dart';
import 'package:movie_stream/networks/status_code.dart';
import 'package:movie_stream/repository/user_repository.dart';
import 'package:movie_stream/utils/app_utils.dart';

class SignUpController {
  final UserRepository _userRepository;
  final BuildContext context;

  SignUpController(this.context, this._userRepository);

  Future<bool> signUp(String username, String email, String password) async {
    final userCreationRequest = UserCreationRequest(
      username: username,
      email: email,
      password: password,
    );

    try {
      final response = await _userRepository.post(userCreationRequest);
      final statusCode = response.statusCode;
      final message = response.message ?? 'Unknown error occurred';

      if (statusCode == HttpStatusCode.OK.code) {
        AppUtil.showSnackBar(context, 'Sign up successful!');
        return true;
      } else if (statusCode == CustomStatusCode.USER_EXISTED.code) {
        AppUtil.showSnackBar(context, 'Sign up failed: $message');
        return false;
      } else {
        AppUtil.showSnackBar(context, 'Sign up failed: Unexpected status code $statusCode');
        return false;
      }
    } catch (e) {
      String errorMessage = _handleException(e as Exception);
      AppUtil.showSnackBar(context, errorMessage);
      return false;
    }
  }

  String _handleException(Exception e) {
    if (e is UserInputException) {
      return 'Input Error: ${e.message}';
    } else if (e is InternalServerException) {
      return 'Server Error: ${e.message}';
    } else {
      return 'An unexpected error occurred';
    }
  }
}
