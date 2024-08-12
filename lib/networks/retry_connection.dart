Future<T> retry<T>(
    Future<T> Function() action, {
      int retries = 2,
      Duration delay = const Duration(seconds: 5),
    }) async {
  for (int i = 0; i < retries; i++) {
    try {
      return await action();
    } catch (e) {
      if (i == retries - 1) rethrow; // Nếu đã thử hết số lần, ném lại lỗi
      await Future.delayed(delay); // Chờ trước khi thử lại
    }
  }
  throw Exception('Failed after retries');
}