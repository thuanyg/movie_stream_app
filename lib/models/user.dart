class User {
  String id;
  String username;
  String email;
  String password;
  String gender;
  String firstName;
  String lastName;
  String dob;
  String avatarUrl;
  List<dynamic> favoriteMovies;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.avatarUrl,
    required this.favoriteMovies,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    gender: json["gender"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    dob: json["dob"],
    avatarUrl: json["avatarUrl"],
    favoriteMovies: List<dynamic>.from(json["favoriteMovies"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "gender": gender,
    "firstName": firstName,
    "lastName": lastName,
    "dob": dob,
    "avatarUrl": avatarUrl,
    "favoriteMovies": List<dynamic>.from(favoriteMovies.map((x) => x)),
  };
}
