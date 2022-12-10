import 'package:flutter/material.dart';
import 'package:imdb/components/snack_bar.dart';
import 'package:imdb/helper/watch_list_db_helper.dart';
import 'package:imdb/model/watch_list_model.dart';
import 'package:imdb/screen/movie_detail/movie_detail_widget.dart';
import 'package:imdb/screen/movie_detail/title_text.dart';

class SavedMoviesWidget extends StatefulWidget {
  const SavedMoviesWidget({super.key});

  @override
  State<SavedMoviesWidget> createState() => _SavedMoviesWidgetState();
}

class _SavedMoviesWidgetState extends State<SavedMoviesWidget> {
  final WatchListDBHelper _watchListDbHelper = WatchListDBHelper();
  late double width;
  late double height;
  WatchListModel? _detail;
  int _movieIndex = 0;

  List<WatchListModel> _watchList = [];
  @override
  void initState() {
    super.initState();

    _getList();
  }

  _getList() async {
    List<WatchListModel> result = await _watchListDbHelper.getAllList();

    setState(() {
      _watchList = result;
      // if (_watchList.isNotEmpty) {
      //   _detail = _watchList.first;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: _watchList.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width,
                  child: Text(
                    "Watch List",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                    ),
                  ),
                ),
                _detail != null
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 16,
                        ),
                        padding: const EdgeInsets.all(16),
                        width: width,
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
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailWidget(
                                id: _detail!.imdbId,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.network(_detail!.imageUrl),
                              TitleAndText(
                                  title: "IMDb Id: ", text: _detail!.imdbId),
                              TitleAndText(
                                  title: "Name: ", text: _detail!.movieName),
                              TitleAndText(
                                  title: "Summary: ", text: _detail!.summary),
                              TitleAndText(
                                  title: "Genres: ", text: _detail!.genres),
                              Container(
                                padding: const EdgeInsets.only(top: 8),
                                width: width,
                                child: ElevatedButton.icon(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.red,
                                    ),
                                  ),
                                  onPressed: () =>
                                      _removeFromList(_detail!, _movieIndex),
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                  label: const Text(
                                    "Remove from List",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("Click a movie"),
                      ),
                SizedBox(
                  height: height * .5,
                  child: ListView.builder(
                    itemCount: _watchList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_watchList[index].imdbId),
                        onDismissed: (direction) =>
                            _removeFromList(_watchList[index], index),
                        background: Container(color: Colors.red),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _detail = _watchList[index];
                              _movieIndex = index;
                            });
                          },
                          onLongPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailWidget(
                                id: _watchList[index].imdbId,
                              ),
                            ),
                          ),
                          leading: const Icon(Icons.movie),
                          title: Text(_watchList[index].movieName),
                          subtitle: Text(_watchList[index].genres),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("Empty List"),
            ),
    );
  }

  _removeFromList(WatchListModel model, int index) async {
    try {
      await _watchListDbHelper.deleteFromWatchList(model.imdbId);
      setState(() {
        _watchList.removeAt(index);
        _detail = _watchList.first;
      });

      ShowSnackBar(
          context: context,
          content: "Removed ${model.movieName}",
          isOkey: false);
    } catch (e) {
      ShowSnackBar(
          context: context, content: "Error! Couldn't remove!", isOkey: false);
    }
  }
}
