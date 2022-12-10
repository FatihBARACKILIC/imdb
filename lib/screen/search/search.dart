import 'package:flutter/material.dart';
import 'package:imdb/components/movie_item.dart';
import 'package:imdb/model/coming_soon_model.dart';
import 'package:imdb/screen/search/search_list.dart';
import 'package:imdb/services/imdb_service.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controllerSearch = TextEditingController();
  late Future<ComingSoonModel> _movieList;
  int _count = 10;

  @override
  void initState() {
    super.initState();

    setState(() {
      _movieList = WebService().comingSoonMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          children: [
            TextField(
              controller: _controllerSearch,
              decoration: const InputDecoration(
                label: Text("Search Movie"),
              ),
              onSubmitted: (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchList(
                    searchText: value,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _movieList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Coming Soon",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      for (int i = 0;
                          i <
                              (data!.items.length > _count
                                  ? _count
                                  : data.items.length);
                          i += 2)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MovieItem(
                              id: data.items[i].id,
                              image: data.items[i].image,
                              title: data.items[i].title,
                              date: data.items[i].releaseState,
                              click: false,
                            ),
                            if (i + 1 < data.items.length)
                              MovieItem(
                                id: data.items[i + 1].id,
                                image: data.items[i + 1].image,
                                title: data.items[i + 1].title,
                                date: data.items[i].releaseState,
                                click: false,
                              ),
                          ],
                        ),
                      if (_count < data.items.length)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _count += 10;
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Load"),
                          ),
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Center(
                    child: Text("Search Movie"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
