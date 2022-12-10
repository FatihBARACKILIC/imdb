class ResultModel {
  ResultModel({
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  });

  String id;
  String resultType;
  String image;
  String title;
  String description;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"],
        resultType: json["resultType"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resultType": resultType,
        "image": image,
        "title": title,
        "description": description,
      };
}
