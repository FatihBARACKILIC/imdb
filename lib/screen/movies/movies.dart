import 'package:flutter/material.dart';
import 'package:imdb/components/carousel_list.dart';
import 'package:imdb/model/most_popular_movies.dart';
import 'package:imdb/model/top_250.dart';
import 'package:imdb/screen/movie_detail/movie_detail_widget.dart';
import 'package:imdb/services/imdb_service.dart';
import 'package:imdb/theme/colors/colors.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  late double width;
  late double height;
  late Future<Top250Model> _top250Movies;
  late Future<MostPopularMoviesModel> _mostPopularMovies;
  late Future<MostPopularMovieItemModel> _mostPopularMovie;

  @override
  void initState() {
    super.initState();
    _top250Movies = WebService().top250Movies();
    _mostPopularMovies = WebService().mostPopularMovies();
    _mostPopularMovie = WebService().mostPopularMovie();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            height: 400,
            child: FutureBuilder(
              future: _mostPopularMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  final image =
                      "https://m.media-amazon.${data.image.split(".")[2]}._V1_Ratio0.6762_AL_.jpg";

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailWidget(id: data.id),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          image,
                          width: width,
                          height: 400,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade700,
                              width: double.infinity,
                              height: 400,
                              alignment: Alignment.center,
                              child: const Text(
                                "Image Not Found",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: width,
                          height: 400,
                          alignment: Alignment.bottomLeft,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                darkestColor,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.title,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("IMDb Top List"),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            height: 300,
            child: FutureBuilder(
              future: _top250Movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.items;
                  return CarouselList(data: data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Most Popular Movies"),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            height: 300,
            child: FutureBuilder(
              future: _mostPopularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.items;
                  return CarouselList(
                    data: data,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
