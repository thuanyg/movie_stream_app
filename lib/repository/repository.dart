import 'package:movie_stream/dto/response/users/api_response.dart';

abstract class Repository<T, TPost, TUpdate> {
  Future<ApiResponse<dynamic>> get();
  Future<ApiResponse<dynamic>> getById(String id);
  Future<ApiResponse<dynamic>> post(TPost t);
  Future<ApiResponse<dynamic>> delete(String id);
  Future<ApiResponse<dynamic> > update(String id, TUpdate t);
}
