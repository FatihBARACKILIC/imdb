class TranslateModel {
  TranslateModel({
    required this.data,
  });

  DataModel data;

  factory TranslateModel.fromJson(Map<String, dynamic> json) => TranslateModel(
        data: DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataModel {
  DataModel({
    required this.translations,
  });

  List<TranslationModel> translations;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        translations: List<TranslationModel>.from(
            json["translations"].map((x) => TranslationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class TranslationModel {
  TranslationModel({
    required this.translatedText,
  });

  String translatedText;

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        translatedText: json["translatedText"],
      );

  Map<String, dynamic> toJson() => {
        "translatedText": translatedText,
      };
}
