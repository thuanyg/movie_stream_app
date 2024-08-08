import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String BASE_URL = "https://phim.nguonc.com/api";

  Future<T> get<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(BASE_URL + endpoint));
    if (response.statusCode == 200) {
      // Giải mã phản hồi JSON
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;

      // Chuyển đổi JSON thành đối tượng cụ thể bằng cách sử dụng hàm fromJson
      return fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
