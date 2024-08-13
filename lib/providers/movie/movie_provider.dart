import 'package:flutter/material.dart';
import 'package:movie_stream/dto/response/movie_by_genre/api_response.dart';
import 'package:movie_stream/dto/response/movie_by_genre/items.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/dto/response/movies/latest_movie_response.dart';
import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/repository/movie_repository.dart';

class MovieProvider with ChangeNotifier {
  bool isLoading = false;

  // Save selected movie
  MovieDetail? movieDetail;

  MovieDetail? get getSelectedMovie => movieDetail;

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

  Future<List<Item>?> getMoviesByGenre(String genre, int page) async {
    final MovieByGenreResponse response =
        await movieRepository.fetchMoviesByGenre(genre, page);
    List<Item>? list = response.data?.items;
    return list;
  }

  Future<MovieDetail> getMovieDetail(String slug) async {
    final MovieDetail response = await movieRepository.getMovieDetail(slug);
    movieDetail = response;
    notifyListeners();
    return response;
  }

  void updateSelectedMovie(MovieDetail newMovie) {
    movieDetail = newMovie;
    notifyListeners();
  }
}
