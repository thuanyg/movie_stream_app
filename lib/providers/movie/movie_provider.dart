import 'package:flutter/material.dart';
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/response/movie_by_genre/api_response.dart';
import 'package:movie_stream/dto/response/movie_by_genre/items.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/dto/response/movies/latest_movie_response.dart';
import 'package:movie_stream/dto/response/movies/search_response.dart';
import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/models/pagination.dart';
import 'package:movie_stream/repository/movie_repository.dart';

class MovieProvider with ChangeNotifier {
  // Save selected movie
  MovieDetail? movieDetail;
  int _currentEpisode = 1;

  // For search/pagination module
  bool isSearchLoading = false;
  bool _isLastPage = false;
  int currentPage = 1;
  List<Item> listMovieResult = [];

  // Dependency Injection Repository
  final MovieRepository movieRepository;

  MovieProvider(this.movieRepository);

  // Getter
  MovieDetail? get getSelectedMovie => movieDetail;

  int get getCurrentEpisode => _currentEpisode;

  bool get isLoading => isSearchLoading;

  bool get isLastPage => _isLastPage;

  List<Item> get getListMovieResult => listMovieResult;

  // Functions
  void updateSelectedMovie(MovieDetail newMovie) {
    movieDetail = newMovie;
    notifyListeners();
  }

  void setCurrentEpisode(int episode) {
    _currentEpisode = episode;
    notifyListeners();
  }

  Future<List<ItemsLatestMovie>?> getListLatestMovie(int page) async {
    final LatestMovieResponse response =
        await movieRepository.fetchLatestMovie(page);
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

  Future<void> searchMovie(
      {required String keyword, required int page, required int limit}) async {
    isSearchLoading = true;
    notifyListeners();

    SearchResponse searchResponse = await movieRepository.searchMovie(
        keyword: keyword, page: page, limit: limit);

    Pagination? pagination = searchResponse.data?.params?.pagination;

    if (currentPage > pagination!.totalPages!) {
      isSearchLoading = false;
      _isLastPage = true;
      notifyListeners();
      return;
    }

    listMovieResult.addAll(searchResponse.data!.items);
    currentPage = page;

    isSearchLoading = false;
    notifyListeners();
  }

  void loadMoreMovies(String keyword) {
    currentPage++;
    if (!isLastPage && !isLoading) {
      searchMovie(
          keyword: keyword, page: currentPage, limit: LIMIT_SEARCH_RESULT);
    }
  }

  void resetData() {
    listMovieResult.clear();
    currentPage = 1;
    _isLastPage = false;
    isSearchLoading = false;
  }
}
