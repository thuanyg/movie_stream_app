import 'package:flutter/material.dart';
import 'package:movie_stream/dto/request/user_creation_request.dart';
import 'package:movie_stream/networks/status_code.dart';
import 'package:movie_stream/repository/user_repository.dart';
import 'package:movie_stream/utils/app_utils.dart';

class SignupProvider with ChangeNotifier {

  bool _isLoading = false;

  final UserRepository _userRepository;

  SignupProvider(this._userRepository);

  bool get isLoading => _isLoading;

  // Functions
  Future<bool> signUp(BuildContext context, String username, String email, String password) async {
    // Create user request model
    final userCreationRequest = UserCreationRequest(
      username: username,
      email: email,
      password: password,
    );

    _isLoading = true;
    notifyListeners();

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
        AppUtil.showSnackBar(
            context, 'Sign up failed: Unexpected status code $statusCode');
        return false;
      }
    } on Exception catch (e) {
      AppUtil.showSnackBar(context, e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
