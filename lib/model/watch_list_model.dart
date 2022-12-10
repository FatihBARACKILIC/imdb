class WatchListModel {
  int? id;
  late String imageUrl;
  late String imdbId;
  late String movieName;
  late String summary;
  late String genres;
  late String youtubeId;

  WatchListModel({
    required this.imageUrl,
    required this.imdbId,
    required this.movieName,
    required this.summary,
    required this.genres,
    required this.youtubeId,
  });

  WatchListModel.withId(
    this.id,
    this.imageUrl,
    this.imdbId,
    this.movieName,
    this.summary,
    this.genres,
    this.youtubeId,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageUrl": imageUrl,
      "imdbId": imdbId,
      "movieName": movieName,
      "summary": summary,
      "genres": genres,
      "youtubeId": youtubeId,
    };
  }

  WatchListModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imageUrl = json["imageUrl"];
    imdbId = json["imdbId"];
    movieName = json["movieName"];
    summary = json["summary"];
    genres = json["genres"];
    youtubeId = json["youtubeId"];
  }
}
