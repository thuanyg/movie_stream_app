class UserCreationResponse {
  final String email, username;

  UserCreationResponse({required this.email, required this.username});

  factory UserCreationResponse.fromJson(Map<String, dynamic> json) =>
      UserCreationResponse(
        username: json["username"],
        email: json["email"],
      );
}
