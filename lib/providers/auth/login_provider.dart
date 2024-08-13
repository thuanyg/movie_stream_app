import 'package:flutter/material.dart';
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/request/auth_request.dart';
import 'package:movie_stream/dto/response/api_response.dart';
import 'package:movie_stream/dto/response/user_info_response.dart';
import 'package:movie_stream/dto/response/verify_token_response.dart';
import 'package:movie_stream/networks/status_code.dart';
import 'package:movie_stream/providers/user/user_provider.dart';
import 'package:movie_stream/repository/auth_repositoy.dart';
import 'package:movie_stream/repository/verify_token_repository.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  UserInfo? _userInfo;
  bool _isLoading = false;

  final AuthRepository _authRepository;
  final VerifyRepository _verifyRepository;

  LoginProvider(this._authRepository, this._verifyRepository);

  bool get isLoading => _isLoading;

  UserInfo? get getUserInfo => _userInfo;

  // Functions
  Future<bool> loginAuthenticate(
      BuildContext context, AuthRequest authRequest) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authRepository.post(authRequest);

      if (response.statusCode == HttpStatusCode.OK.code &&
          response.data != null) {
        // Save JWT token to SecureStorage
        String? token = response.data?.token; // null-aware operator
        AppUtil.writeSecureStorage(USER_TOKEN_KEY, token);

        // Fetch User information
        final verifyTokenResponse = await handleValidToken();

        if (verifyTokenResponse != null && verifyTokenResponse.valid) {
          String? id = verifyTokenResponse.userid.toString();
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          await userProvider.fetchUserByID(id);
        }

        return true;
      }

      if (response.statusCode == CustomStatusCode.INVALID_LOGIN.code) {
        AppUtil.showSnackBar(context, CustomStatusCode.INVALID_LOGIN.message);
        return false;
      }

      if (response.statusCode == CustomStatusCode.USER_NOT_EXISTED.code) {
        AppUtil.showSnackBar(
            context, CustomStatusCode.USER_NOT_EXISTED.message);
        return false;
      }

      return false;
    } on Exception catch (e) {
      AppUtil.showSnackBar(context, e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<VerifyTokenResponse?> handleValidToken() async {
    String? token = await AppUtil.readSecureStorage(USER_TOKEN_KEY);

    if (token == null) return null;
    ApiResponse<VerifyTokenResponse> apiResponse =
        await _verifyRepository.verifyToken(token);
    VerifyTokenResponse? tokenResponse = apiResponse.data;

    if (tokenResponse != null) {
      return tokenResponse;
    }
    return null;
  }
}
