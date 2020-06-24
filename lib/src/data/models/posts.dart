import 'dart:convert';

import 'result.dart';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  Posts({
    this.meta,
    this.result,
  });

  Meta meta;
  List<Result> result;

  factory Posts.fromJson(Map<String, dynamic> json) {
    final resultList =
        List<Result>.from(json["result"].map((x) => Result.fromJson(x)));
    // print(resultList);
    return Posts(
      meta: Meta.fromJson(json["_meta"]),
      result: resultList,
    );
  }

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Meta {
  Meta({
    this.pageCount,
    this.currentPage,
    this.perPage,
  });

  int pageCount;
  int currentPage;
  int perPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
      );

  Map<String, dynamic> toJson() => {
        "pageCount": pageCount,
        "currentPage": currentPage,
        "perPage": perPage,
      };
}
