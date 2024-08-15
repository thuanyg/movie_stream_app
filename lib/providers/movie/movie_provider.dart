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

  // Search/pagination module
  bool isSearchLoading = false;
  bool _isLastPage = false;
  int currentPage = 1;
  List<Item> listMovieResult = [];

  // See all movies by genre pagination
  bool _isSeeAllLoading = false;
  bool _isSeeAllLastPage = false;
  int _currentPageSeeAll = 1;
  List<Item> listMovieByGenre = [];

  // See all latest movies pagination
  bool _isLatestLoading = false;
  bool _isLatestLastPage = false;
  int _currentPageLatest = 1;
  List<ItemsLatestMovie> listLatestMovie = [];

  // Dependency Injection Repository
  final MovieRepository movieRepository;

  MovieProvider(this.movieRepository);

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
    _isLatestLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final LatestMovieResponse response =
        await movieRepository.fetchLatestMovie(page);

    if (_currentPageLatest > response.pagination!.totalPages!.toInt()) {
      _isLatestLoading = false;
      _isLatestLastPage = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return [];
    }

    listLatestMovie.addAll(response.items!);
    _isLatestLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    return response.items;
  }

  Future<List<Item>?> getMoviesByCategory(String category, int page) async {
    final MovieByGenreResponse response =
        await movieRepository.fetchMoviesByGenre(category, page);
    return response.data?.items;
  }

  Future<List<Item>> getMoviesByGenre(String genre, int page) async {
    _isSeeAllLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final MovieByGenreResponse response =
        await movieRepository.fetchMoviesByGenre(genre, page);

    Pagination? pagination = response.data!.params?.pagination;

    if (currentPageSeeAll > pagination!.totalPages!) {
      _isSeeAllLoading = false;
      _isSeeAllLastPage = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return [];
    }

    listMovieByGenre.addAll(response.data!.items);
    _isSeeAllLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    return response.data!.items;
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

  void loadMoreLatestMovie() {
    _currentPageLatest++;
    if (!_isLatestLoading && !_isLatestLastPage) {
      getListLatestMovie(_currentPageLatest);
    }
  }

  void loadMoreGenreMovie(String genre) {
    _currentPageSeeAll++;
    if (!_isSeeAllLoading && !_isSeeAllLastPage) {
      getMoviesByGenre(genre, _currentPageSeeAll);
    }
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

    _isSeeAllLastPage = false;
    _isSeeAllLoading = false;
    listMovieByGenre.clear();
    _currentPageSeeAll = 1;

    _isLatestLastPage = false;
    _isLatestLoading = false;
    _currentPageLatest = 1;
    listLatestMovie.clear();
  }

  // Getter
  MovieDetail? get getSelectedMovie => movieDetail;

  int get getCurrentEpisode => _currentEpisode;

  bool get isLoading => isSearchLoading;

  bool get isLastPage => _isLastPage;

  int get currentEpisode => _currentEpisode;

  List<Item> get getListMovieResult => listMovieResult;

  bool get isSeeAllLoading => _isSeeAllLoading;

  bool get isSeeAllLastPage => _isSeeAllLastPage;

  int get currentPageSeeAll => _currentPageSeeAll;

  bool get isLatestLoading => _isLatestLoading;

  List<Item> get getListMovieByGenre => listMovieByGenre;

  bool get isLatestLastPage => _isLatestLastPage;

  int get currentPageLatest => _currentPageLatest;
}
