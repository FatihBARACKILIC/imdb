import 'package:flutter/material.dart';
import 'package:imdb/components/movie_item.dart';
import 'package:imdb/model/result_model.dart';
import 'package:imdb/model/search_model.dart';
import 'package:imdb/view_model/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchList extends StatelessWidget {
  final String searchText;

  const SearchList({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(searchText),
      child: Consumer<SearchViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(searchText.toUpperCase()),
              centerTitle: true,
            ),
            body: SafeArea(
              child: bodyWidget(context),
            ),
          );
        },
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    if (context.watch<SearchViewModel>().state == SearchState.busy) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (context.watch<SearchViewModel>().state == SearchState.error) {
      return const Center(
        child: Text("error"),
      );
    } else {
      return const BuildMovieList();
    }
  }
}

class BuildMovieList extends StatefulWidget {
  const BuildMovieList({super.key});

  @override
  State<BuildMovieList> createState() => _BuildMovieListState();
}

class _BuildMovieListState extends State<BuildMovieList> {
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    SearchModel searchModel = context.read<SearchViewModel>().searchModel;
    List<ResultModel> results = searchModel.results;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Research count: ${results.length}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              for (int i = 0;
                  i <= (results.length > _count ? _count : results.length);
                  i += 2)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieItem(
                      id: results[i].id,
                      image: results[i].image,
                      title: results[i].title,
                    ),
                    if (i + 1 < results.length)
                      MovieItem(
                        id: results[i + 1].id,
                        image: results[i + 1].image,
                        title: results[i + 1].title,
                      ),
                  ],
                ),
              if (_count < results.length)
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
          ),
        ),
      ),
    );
  }
}
