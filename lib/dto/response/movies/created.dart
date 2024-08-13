class Created {
  Created({
    required this.time,
  });

  final DateTime time;

  factory Created.fromJson(Map<String, dynamic> json){
    return Created(
      time: DateTime.parse(json["time"] ?? ""),
    );
  }

}