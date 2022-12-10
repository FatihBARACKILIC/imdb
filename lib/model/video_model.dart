import 'dart:convert';

VideoModel mostPopularMoviesFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String mostPopularMoviesToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.imDbId,
    required this.title,
    required this.fullTitle,
    required this.type,
    required this.year,
    this.videoId,
    this.videoUrl,
    this.errorMessage,
  });

  String imDbId;
  String title;
  String fullTitle;
  String type;
  String year;
  String? videoId;
  String? videoUrl;
  String? errorMessage;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        imDbId: json["imDbId"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        videoId: json["videoId"],
        videoUrl: json["videoUrl"],
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "imDbId": imDbId,
        "title": title,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "videoId": videoId,
        "videoUrl": videoUrl,
        "errorMessage": errorMessage,
      };
}
