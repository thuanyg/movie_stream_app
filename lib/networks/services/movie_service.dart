import 'package:movie_stream/models/movies_response.dart';
import 'package:movie_stream/networks/api_service.dart';

class MovieService {
  final ApiService apiService;

  MovieService({required this.apiService});

  Future<MoviesResponse> fetchListMovies(int page) async {
    final String endpoint = '/films/phim-moi-cap-nhat?page=$page';
    try {
      return apiService.get(endpoint, (json) => MoviesResponse.fromJson(json));
    } catch (e) {
      // Xử lý lỗi và thông báo cho người dùng nếu cần
      throw Exception('Failed to fetch movies: $e');
    }
  }
}
