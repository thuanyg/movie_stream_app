import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:movie_stream/dto/request/favorite_request.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/dto/response/users/api_response.dart';
import 'package:movie_stream/dto/response/users/favorite_creation_response.dart';
import 'package:movie_stream/dto/response/users/favorite_response.dart';
import 'package:movie_stream/networks/status_code.dart';
import 'package:movie_stream/repository/favorite_repository.dart';

class FavoriteProvider with ChangeNotifier {
  List<FavoriteResponse> _favoriteMovies = [];
  bool _isSaved = false;

  FavoriteRepository favoriteRepo;

  FavoriteProvider(this.favoriteRepo);

  List<FavoriteResponse> get getListFavoriteMovie => _favoriteMovies;

  bool get isSaved => _isSaved;

  Future<List<FavoriteResponse>?> getFavoriteMovies(String userid) async {
    ApiResponse<List<FavoriteResponse>> apiResponse =
        await favoriteRepo.fetchFavoriteMovies(userid);

    if (apiResponse.statusCode == CustomStatusCode.USER_NOT_EXISTED) {
      return null;
    }

    if (apiResponse.statusCode == HttpStatusCode.OK.code) {
      _favoriteMovies.clear();
      _favoriteMovies.addAll(apiResponse.data!);
      notifyListeners();
      return apiResponse.data;
    }

    return null;
  }

  Future<bool> createFavoriteMovies(FavoriteRequest movieRequest) async {
    ApiResponse<FavoriteCreationResponse>? apiResponse =
        await favoriteRepo.createFavoriteMovie(movieRequest);
    if (apiResponse?.statusCode == 200 && apiResponse?.data != null) {
      _isSaved = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return true;
    }
    return false;
  }

  Future<bool> deleteFavoriteMovies(int favID) async {
    ApiResponse<String>? apiResponse =
        await favoriteRepo.deleteFavoriteMovie(favID);
    if (apiResponse?.statusCode == 200) {
      _favoriteMovies.removeWhere((movie) => movie.favoriteMovieId == favID);
      _isSaved = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return true;
    }
    return false;
  }

  void updateList(FavoriteResponse newData) {
    _favoriteMovies.add(newData);
  }

  bool checkSavedMovie(String slug) {
    bool isSave = _favoriteMovies.any((movie) => movie.slug == slug);
    _isSaved = isSave;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    return isSave;
  }
}
