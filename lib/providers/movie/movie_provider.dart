import 'package:flutter/material.dart';
import 'package:movie_stream/dto/response/movies/latest_movie_response.dart';
import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/repository/movie_repository.dart';

class MovieProvider with ChangeNotifier {
  bool isLoading = false;

  final MovieRepository movieRepository;

  MovieProvider(this.movieRepository);

  Future<List<ItemsLatestMovie>?> getListLatestMovie(int page) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading = true;
      notifyListeners();
    });

    final LatestMovieResponse response =
        await movieRepository.fetchLatestMovie(page);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading = false;
      notifyListeners();
    });
    return response.items;
  }
}
