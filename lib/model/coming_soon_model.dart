class ComingSoonModel {
  List<ItemModel> items;
  String errorMessage;

  ComingSoonModel({
    required this.items,
    required this.errorMessage,
  });

  factory ComingSoonModel.fromJson(Map<String, dynamic> json) =>
      ComingSoonModel(
        items: List<ItemModel>.from(
            json["items"].map((x) => ItemModel.fromJson(x))),
        errorMessage: json["errorMessage"],
      );
}

class ItemModel {
  String id;
  String title;
  String fullTitle;
  String year;
  String releaseState;
  String image;
  dynamic runtimeMins;
  dynamic runtimeStr;
  dynamic plot;
  dynamic contentRating;
  dynamic imDbRating;
  dynamic imDbRatingCount;
  dynamic metacriticRating;
  String genres;
  List<GenreListModel> genreList;
  dynamic directors;
  List<dynamic> directorList;
  String stars;
  List<StarListModel> starList;

  ItemModel({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.releaseState,
    required this.image,
    this.runtimeMins,
    this.runtimeStr,
    this.plot,
    this.contentRating,
    this.imDbRating,
    this.imDbRatingCount,
    this.metacriticRating,
    required this.genres,
    required this.genreList,
    this.directors,
    required this.directorList,
    required this.stars,
    required this.starList,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        releaseState: json["releaseState"],
        image: json["image"],
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
        metacriticRating: json["metacriticRating"],
        genres: json["genres"],
        genreList: List<GenreListModel>.from(
            json["genreList"].map((x) => GenreListModel.fromJson(x))),
        directors: json["directors"],
        directorList: List<dynamic>.from(json["directorList"].map((x) => x)),
        stars: json["stars"],
        starList: List<StarListModel>.from(
            json["starList"].map((x) => StarListModel.fromJson(x))),
      );
}

class GenreListModel {
  String key;
  String value;

  GenreListModel({
    required this.key,
    required this.value,
  });

  factory GenreListModel.fromJson(Map<String, dynamic> json) => GenreListModel(
        key: json["key"],
        value: json["value"],
      );
}

class StarListModel {
  dynamic id;
  String name;

  StarListModel({
    this.id,
    required this.name,
  });

  factory StarListModel.fromJson(Map<String, dynamic> json) => StarListModel(
        id: json["id"],
        name: json["name"],
      );
}
