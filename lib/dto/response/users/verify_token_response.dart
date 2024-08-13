class VerifyTokenResponse {
  bool valid;
  String? userid;

  VerifyTokenResponse(this.valid, this.userid);

  factory VerifyTokenResponse.fromJson(Map<String, dynamic> json) =>
      VerifyTokenResponse(json["valid"], json["userid"]);
}
