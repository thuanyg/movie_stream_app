class UserCreationRequest {
  String username;
  String email;
  String password;
  String? gender;
  String? firstName;
  String? lastName;
  String? dob;
  String? avatarUrl;

  UserCreationRequest({
    required this.username,
    required this.email,
    required this.password,
    this.gender,
    this.firstName,
    this.lastName,
    this.dob,
    this.avatarUrl,
  });

  factory UserCreationRequest.fromJson(Map<String, dynamic> json) => UserCreationRequest(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "gender": gender,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "avatarUrl": avatarUrl,
      };
}
