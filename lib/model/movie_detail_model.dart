// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

MovieDetailModel movieDetailFromJson(String str) =>
    MovieDetailModel.fromJson(json.decode(str));

String movieDetailToJson(MovieDetailModel data) => json.encode(data.toJson());

class MovieDetailModel {
  MovieDetailModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.fullTitle,
    required this.type,
    required this.year,
    required this.image,
    required this.releaseDate,
    required this.runtimeMins,
    required this.runtimeStr,
    required this.plot,
    required this.plotLocal,
    required this.plotLocalIsRtl,
    required this.awards,
    required this.directors,
    required this.directorList,
    required this.writers,
    required this.writerList,
    required this.stars,
    required this.starList,
    required this.actorList,
    this.fullCast,
    required this.genres,
    required this.genreList,
    required this.companies,
    required this.companyList,
    required this.countries,
    required this.countryList,
    required this.languages,
    required this.languageList,
    required this.contentRating,
    required this.imDbRating,
    required this.imDbRatingVotes,
    required this.metacriticRating,
    this.ratings,
    this.wikipedia,
    this.posters,
    this.images,
    this.trailer,
    required this.boxOffice,
    this.tagline,
    required this.keywords,
    required this.keywordList,
    required this.similars,
    this.tvSeriesInfo,
    this.tvEpisodeInfo,
    this.errorMessage,
  });

  String id;
  String title;
  String originalTitle;
  String fullTitle;
  String type;
  String year;
  String image;
  DateTime releaseDate;
  String runtimeMins;
  String runtimeStr;
  String plot;
  String plotLocal;
  bool plotLocalIsRtl;
  String awards;
  String directors;
  List<CompanyListElementModel> directorList;
  String writers;
  List<CompanyListElementModel> writerList;
  String stars;
  List<CompanyListElementModel> starList;
  List<ActorListModel> actorList;
  dynamic fullCast;
  String genres;
  List<CountryListElementModel> genreList;
  String companies;
  List<CompanyListElementModel> companyList;
  String countries;
  List<CountryListElementModel> countryList;
  String languages;
  List<CountryListElementModel> languageList;
  String contentRating;
  String imDbRating;
  String imDbRatingVotes;
  String metacriticRating;
  dynamic ratings;
  dynamic wikipedia;
  dynamic posters;
  dynamic images;
  dynamic trailer;
  BoxOfficeModel boxOffice;
  dynamic tagline;
  String keywords;
  List<String> keywordList;
  List<SimilarModel> similars;
  dynamic tvSeriesInfo;
  dynamic tvEpisodeInfo;
  dynamic errorMessage;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        id: json["id"],
        title: json["title"],
        originalTitle: json["originalTitle"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        image: json["image"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        runtimeMins: json["runtimeMins"] ?? "null",
        runtimeStr: json["runtimeStr"] ?? "null",
        plot: json["plot"],
        plotLocal: json["plotLocal"],
        plotLocalIsRtl: json["plotLocalIsRtl"],
        awards: json["awards"],
        directors: json["directors"],
        directorList: List<CompanyListElementModel>.from(json["directorList"]
            .map((x) => CompanyListElementModel.fromJson(x))),
        writers: json["writers"],
        writerList: List<CompanyListElementModel>.from(
            json["writerList"].map((x) => CompanyListElementModel.fromJson(x))),
        stars: json["stars"],
        starList: List<CompanyListElementModel>.from(
            json["starList"].map((x) => CompanyListElementModel.fromJson(x))),
        actorList: List<ActorListModel>.from(
            json["actorList"].map((x) => ActorListModel.fromJson(x))),
        fullCast: json["fullCast"] ?? "null",
        genres: json["genres"],
        genreList: List<CountryListElementModel>.from(
            json["genreList"].map((x) => CountryListElementModel.fromJson(x))),
        companies: json["companies"],
        companyList: List<CompanyListElementModel>.from(json["companyList"]
            .map((x) => CompanyListElementModel.fromJson(x))),
        countries: json["countries"],
        countryList: List<CountryListElementModel>.from(json["countryList"]
            .map((x) => CountryListElementModel.fromJson(x))),
        languages: json["languages"],
        languageList: List<CountryListElementModel>.from(json["languageList"]
            .map((x) => CountryListElementModel.fromJson(x))),
        contentRating: json["contentRating"] ?? "null",
        imDbRating: json["imDbRating"] ?? "null",
        imDbRatingVotes: json["imDbRatingVotes"] ?? "null",
        metacriticRating: json["metacriticRating"] ?? "null",
        ratings: json["ratings"] ?? "null",
        wikipedia: json["wikipedia"] ?? "null",
        posters: json["posters"] ?? "null",
        images: json["images"] ?? "null",
        trailer: json["trailer"] ?? "null",
        boxOffice: BoxOfficeModel.fromJson(json["boxOffice"]),
        tagline: json["tagline"] ?? "null",
        keywords: json["keywords"],
        keywordList: List<String>.from(json["keywordList"].map((x) => x)),
        similars: List<SimilarModel>.from(
            json["similars"].map((x) => SimilarModel.fromJson(x))),
        tvSeriesInfo: json["tvSeriesInfo"] ?? "null",
        tvEpisodeInfo: json["tvEpisodeInfo"] ?? "null",
        errorMessage: json["errorMessage"] ?? "null",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalTitle": originalTitle,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "image": image,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "runtimeMins": runtimeMins,
        "runtimeStr": runtimeStr,
        "plot": plot,
        "plotLocal": plotLocal,
        "plotLocalIsRtl": plotLocalIsRtl,
        "awards": awards,
        "directors": directors,
        "directorList": List<dynamic>.from(directorList.map((x) => x.toJson())),
        "writers": writers,
        "writerList": List<dynamic>.from(writerList.map((x) => x.toJson())),
        "stars": stars,
        "starList": List<dynamic>.from(starList.map((x) => x.toJson())),
        "actorList": List<dynamic>.from(actorList.map((x) => x.toJson())),
        "fullCast": fullCast ?? "null",
        "genres": genres,
        "genreList": List<dynamic>.from(genreList.map((x) => x.toJson())),
        "companies": companies,
        "companyList": List<dynamic>.from(companyList.map((x) => x.toJson())),
        "countries": countries,
        "countryList": List<dynamic>.from(countryList.map((x) => x.toJson())),
        "languages": languages,
        "languageList": List<dynamic>.from(languageList.map((x) => x.toJson())),
        "contentRating": contentRating,
        "imDbRating": imDbRating,
        "imDbRatingVotes": imDbRatingVotes,
        "metacriticRating": metacriticRating,
        "ratings": ratings ?? "null",
        "wikipedia": wikipedia ?? "null",
        "posters": posters ?? "null",
        "images": images ?? "null",
        "trailer": trailer ?? "null",
        "boxOffice": boxOffice.toJson(),
        "tagline": tagline,
        "keywords": keywords,
        "keywordList": List<dynamic>.from(keywordList.map((x) => x)),
        "similars": List<dynamic>.from(similars.map((x) => x.toJson())),
        "tvSeriesInfo": tvSeriesInfo ?? "null",
        "tvEpisodeInfo": tvEpisodeInfo ?? "null",
        "errorMessage": errorMessage ?? "null",
      };
}

class ActorListModel {
  ActorListModel({
    required this.id,
    required this.image,
    required this.name,
    required this.asCharacter,
  });

  String id;
  String image;
  String name;
  String asCharacter;

  factory ActorListModel.fromJson(Map<String, dynamic> json) => ActorListModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        asCharacter: json["asCharacter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "asCharacter": asCharacter,
      };
}

class BoxOfficeModel {
  BoxOfficeModel({
    required this.budget,
    required this.openingWeekendUsa,
    required this.grossUsa,
    required this.cumulativeWorldwideGross,
  });

  String budget;
  String openingWeekendUsa;
  String grossUsa;
  String cumulativeWorldwideGross;

  factory BoxOfficeModel.fromJson(Map<String, dynamic> json) => BoxOfficeModel(
        budget: json["budget"],
        openingWeekendUsa: json["openingWeekendUSA"],
        grossUsa: json["grossUSA"],
        cumulativeWorldwideGross: json["cumulativeWorldwideGross"],
      );

  Map<String, dynamic> toJson() => {
        "budget": budget,
        "openingWeekendUSA": openingWeekendUsa,
        "grossUSA": grossUsa,
        "cumulativeWorldwideGross": cumulativeWorldwideGross,
      };
}

class CompanyListElementModel {
  CompanyListElementModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory CompanyListElementModel.fromJson(Map<String, dynamic> json) =>
      CompanyListElementModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CountryListElementModel {
  CountryListElementModel({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory CountryListElementModel.fromJson(Map<String, dynamic> json) =>
      CountryListElementModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class SimilarModel {
  SimilarModel({
    required this.id,
    required this.title,
    required this.image,
    required this.imDbRating,
  });

  String id;
  String title;
  String image;
  String imDbRating;

  factory SimilarModel.fromJson(Map<String, dynamic> json) => SimilarModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imDbRating: json["imDbRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imDbRating": imDbRating,
      };
}
