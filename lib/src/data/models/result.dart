class Result {
  Result({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  String id;
  String userId;
  String title;
  String body;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "body": body,
      };
}
