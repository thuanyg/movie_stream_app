class UserInfo {
  String id;
  String username;
  String email;
  String? gender;
  String? firstName;
  String? lastName;
  String? dob;
  String? avatarUrl;

  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.avatarUrl,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        gender: json["gender"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        avatarUrl: json["avatarUrl"],
      );

  @override
  String toString() {
    return 'UserInfo{id: $id, username: $username, email: $email, gender: $gender, firstName: $firstName, lastName: $lastName, dob: $dob, avatarUrl: $avatarUrl}';
  }
}
