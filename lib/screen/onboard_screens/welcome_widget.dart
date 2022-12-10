import 'package:flutter/material.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:imdb/components/image_network.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final List<String> _moviePosters = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    setState(() {
      //> Godfather
      _moviePosters.add(
          "https://m.media-amazon.com/images/M/MV5BMjQ3MDk1ZDgtNTE5NS00OTcxLWI5YjMtNWNkMjU2YWYwYWRjXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_FMjpg_UX600_.jpg");

      //> Joker
      _moviePosters.add(
          "https://m.media-amazon.com/images/M/MV5BZWFiNzBkYjEtMmY4My00MDFjLTg2NTUtMzI2ODZlZjBjYzc3XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1012_.jpg");

      //> Avengers
      _moviePosters.add(
          "https://m.media-amazon.com/images/M/MV5BMTkxNTQzNTg4Nl5BMl5BanBnXkFtZTgwMzYzNDQ2NzM@._V1_.jpg");

      _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05,
            vertical: MediaQuery.of(context).size.height * .05,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: imdbYellowColor,
                  ),
                  width: double.infinity,
                  child: Image.asset("assets/imdb_logo.png"),
                ),
              ),
              Expanded(
                flex: 7,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {},
                  itemCount: _moviePosters.length,
                  pageSnapping: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ImageNetwork(imageURL: _moviePosters[index]),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: const [
                      FittedBox(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Every Movie and Series1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Summaries, trailers, actors, directors and everything about cinema and TV here.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
