import 'dart:convert';
import 'dart:io';

import 'package:imdb/constant/api_urls.dart';
import 'package:imdb/model/coming_soon_model.dart';
import 'package:imdb/model/most_popular_movies.dart';
import 'package:imdb/model/movie_detail_model.dart';
import 'package:imdb/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:imdb/model/top_250.dart';
import 'package:imdb/model/video_model.dart';

class WebService {
  Future<SearchModel> searchMovie(String searchText) async {
    try {
      final response = await http.get(Uri.parse(
          "${ApiUrls.searchUrl}${searchText.replaceAll(' ', '%20')}"));

      if (response.statusCode == HttpStatus.ok) {
        return searchFromJson(response.body);
      } else {
        return SearchModel(
          searchType: "searchType",
          expression: "expression",
          results: [],
          errorMessage: "",
        );
      }
    } catch (e) {
      return SearchModel(
        searchType: "searchType",
        expression: "expression",
        results: [],
        errorMessage: "",
      );
    }
  }

  Future<ComingSoonModel> comingSoonMovies() async {
    final response = await http.get(Uri.parse(ApiUrls.comingSoonUrl));

    if (response.statusCode == HttpStatus.ok) {
      return ComingSoonModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Failed to load movie!");
    }
  }

  Future<MovieDetailModel> movieDetail(String id) async {
    final response = await http.get(Uri.parse("${ApiUrls.movieDetailUrl}$id"));

    if (response.statusCode == HttpStatus.ok) {
      return MovieDetailModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Failed to load movie!");
    }
  }

  Future<Top250Model> top250Movies() async {
    final response = await http.get(
      Uri.parse(
        ApiUrls.top250Movie,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return Top250Model.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception("Failed to load top 250 Movies!");
    }
  }

  Future<MostPopularMoviesModel> mostPopularMovies() async {
    final response = await http.get(
      Uri.parse(
        ApiUrls.mostPopularMovies,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return MostPopularMoviesModel.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception("Failed to load Most Popular Movies!");
    }
  }

  Future<MostPopularMovieItemModel> mostPopularMovie() async {
    final response = await http.get(
      Uri.parse(
        ApiUrls.mostPopularMovies,
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return MostPopularMoviesModel.fromJson(
        jsonDecode(
          response.body,
        ),
      ).items.first;
    } else {
      throw Exception("Failed to load Most Popular Movies!");
    }
  }

  Future<VideoModel> getVideoUrl(String id) async {
    final response = await http.get(
      Uri.parse(
        "${ApiUrls.youtubeUrl}$id",
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return VideoModel.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Exception("Failed to load Youtube!");
    }
  }
}
