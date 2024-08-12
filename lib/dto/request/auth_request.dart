class AuthRequest {
  String username;
  String email;
  String password;

  AuthRequest(this.username, this.email, this.password);

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
