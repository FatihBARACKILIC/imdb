import 'dart:convert';

Top250Model top250FromJson(String str) =>
    Top250Model.fromJson(json.decode(str));

String top250ToJson(Top250Model data) => json.encode(data.toJson());

class Top250Model {
  Top250Model({
    required this.items,
    required this.errorMessage,
  });

  List<Top250MovieModel> items;
  String errorMessage;

  factory Top250Model.fromJson(Map<String, dynamic> json) => Top250Model(
        items: List<Top250MovieModel>.from(
            json["items"].map((x) => Top250MovieModel.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Top250MovieModel {
  Top250MovieModel({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });

  String id;
  String rank;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  factory Top250MovieModel.fromJson(Map<String, dynamic> json) =>
      Top250MovieModel(
        id: json["id"],
        rank: json["rank"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        image: json["image"],
        crew: json["crew"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
