class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final data = json['data'];
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      data: data != null ? fromJsonT(data) : null,
    );
  }

  Map<String, dynamic> toJson(dynamic Function(dynamic) toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}
