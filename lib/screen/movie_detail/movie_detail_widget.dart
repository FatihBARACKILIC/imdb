import 'package:flutter/material.dart';
import 'package:imdb/components/snack_bar.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/helper/watch_list_db_helper.dart';
import 'package:imdb/model/movie_detail_model.dart';
import 'package:imdb/model/video_model.dart';
import 'package:imdb/model/watch_list_model.dart';
import 'package:imdb/screen/movie_detail/title_text.dart';
import 'package:imdb/screen/movie_detail/youtube_player.dart';
import 'package:imdb/services/imdb_service.dart';
import 'package:imdb/services/translate_service.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailWidget extends StatefulWidget {
  const MovieDetailWidget({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<MovieDetailWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  final WatchListDBHelper _watchListDBHelper = WatchListDBHelper();
  late Future<MovieDetailModel> _movieDetail;
  late Future<VideoModel> _videoUrl;
  String _summary = "";
  String lang = "en";
  late double width;
  late double height;
  late String _youtubeId;
  bool _isAdded = false;

  @override
  void initState() {
    super.initState();

    _getLang();

    _movieDetail = WebService().movieDetail(widget.id);
    _videoUrl = WebService().getVideoUrl(widget.id);

    _isAddedToList();
  }

  _getLang() async {
    String data = await SharedPreferencesHelper.selectedLanguage();
    setState(() {
      lang = data;
    });
  }

  _isAddedToList() async {
    bool result = await _watchListDBHelper.isAdded(widget.id);
    setState(() {
      _isAdded = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<MovieDetailModel>(
            future: _movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieDetailModel data = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          data.fullTitle,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: width,
                        child: Image.network(
                          data.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      FutureBuilder(
                        future: _videoUrl,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _youtubeId = snapshot.data!.videoId!;
                            return Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              width: width,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => YoutubePage(
                                        id: snapshot.data!.videoId!,
                                      ),
                                    ),
                                  );
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(purpleColor),
                                ),
                                icon: const Icon(Icons.movie),
                                label: const Text("Watch Trailer"),
                              ),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.only(top: 8),
                              width: width,
                              child: ElevatedButton.icon(
                                onPressed: null,
                                icon: const Icon(Icons.error_outline),
                                label: const Text("Trailer not found"),
                              ),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * .46,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final response = await TranslateService()
                                    .translate(data.plot, lang);
                                setState(() {
                                  _summary = response;
                                });
                              },
                              icon: const Icon(Icons.translate),
                              label: const Text("Translate"),
                            ),
                          ),
                          SizedBox(
                            width: width * .46,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Share.share(
                                  "https://www.imdb.com/title/${data.id}",
                                );
                              },
                              icon: const Icon(Icons.share),
                              label: const Text("Share"),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        width: width,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_isAdded) {
                              _deleteFromWatchList(data.id);
                            } else {
                              WatchListModel watchListModel = WatchListModel(
                                imageUrl: data.image,
                                imdbId: data.id,
                                movieName: data.fullTitle,
                                summary: data.plot,
                                genres: _addCommaToGenreList(data.genreList),
                                youtubeId: _youtubeId,
                              );
                              _insertToWatchList(watchListModel);
                            }
                          },
                          icon: Icon(_isAdded ? Icons.delete : Icons.add),
                          label: Text(
                            _isAdded
                                ? "Remove from Watch List"
                                : "Add to Watch List",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Summary: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _summary.isNotEmpty
                                        ? _summary
                                        : data.plot,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .fontSize,
                                ),
                              ),
                            ),
                            TitleAndText(title: "Awards: ", text: data.awards),
                            TitleAndText(
                              title: "Genres: ",
                              text: _addCommaToGenreList(data.genreList),
                            ),
                            TitleAndText(
                              title: "Actors: ",
                              text: _addCommaToActorList(data.actorList),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  String _addCommaToActorList(List actorList) {
    String actors = "";
    for (int i = 0; i < actorList.length; i++) {
      if (i < actorList.length - 1) {
        actors += actorList[i].name + ", ";
      } else {
        actors += actorList[i].name;
      }
    }

    return actors;
  }

  String _addCommaToGenreList(List genreList) {
    String genres = "";
    for (int i = 0; i < genreList.length; i++) {
      if (i < genreList.length - 1) {
        genres += genreList[i].value + ", ";
      } else {
        genres += genreList[i].value;
      }
    }

    return genres;
  }

  _insertToWatchList(WatchListModel watchList) async {
    try {
      await _watchListDBHelper.insertToWatchList(watchList);

      setState(() {
        _isAdded = !_isAdded;
      });
      ShowSnackBar(
          context: context, content: "Movie added to your watch list.");
    } catch (e) {
      ShowSnackBar(
        context: context,
        content: "Error! The Movie Couldn't add!",
        isOkey: false,
      );
    }
  }

  _deleteFromWatchList(String id) async {
    try {
      await _watchListDBHelper.deleteFromWatchList(id);
      setState(() {
        _isAdded = !_isAdded;
      });
      ShowSnackBar(
          context: context, content: "Movie removed from your watch list.");
    } catch (e) {
      ShowSnackBar(
        context: context,
        content: "Error! The Movie Couldn't remove!",
        isOkey: false,
      );
    }
  }
}
