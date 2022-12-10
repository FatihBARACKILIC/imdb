import 'dart:convert';

MostPopularMoviesModel mostPopularMoviesFromJson(String str) =>
    MostPopularMoviesModel.fromJson(json.decode(str));

String mostPopularMoviesToJson(MostPopularMoviesModel data) =>
    json.encode(data.toJson());

class MostPopularMoviesModel {
  MostPopularMoviesModel({
    required this.items,
    required this.errorMessage,
  });

  List<MostPopularMovieItemModel> items;
  String errorMessage;

  factory MostPopularMoviesModel.fromJson(Map<String, dynamic> json) =>
      MostPopularMoviesModel(
        items: List<MostPopularMovieItemModel>.from(
            json["items"].map((x) => MostPopularMovieItemModel.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class MostPopularMovieItemModel {
  MostPopularMovieItemModel({
    required this.id,
    required this.rank,
    required this.rankUpDown,
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
  String rankUpDown;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  factory MostPopularMovieItemModel.fromJson(Map<String, dynamic> json) =>
      MostPopularMovieItemModel(
        id: json["id"],
        rank: json["rank"],
        rankUpDown: json["rankUpDown"],
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
        "rankUpDown": rankUpDown,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
