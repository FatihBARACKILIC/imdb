import 'package:flutter/cupertino.dart';
import 'package:imdb/model/search_model.dart';
import 'package:imdb/services/imdb_service.dart';

enum SearchState { idle, busy, error }

class SearchViewModel with ChangeNotifier {
  SearchState _state = SearchState.busy;

  late SearchModel searchModel;
  late String searchText;

  SearchViewModel(this.searchText) {
    // _searchModel = SearchModel();
    _state = SearchState.idle;
    searchMovie();
  }

  SearchState get state => _state;

  set state(SearchState state) {
    _state = state;
    notifyListeners();
  }

  Future<SearchModel> searchMovie() async {
    try {
      state = SearchState.busy;
      searchModel = await WebService().searchMovie(searchText);
      state = SearchState.idle;

      return searchModel;
    } catch (e) {
      state = SearchState.error;
      return SearchModel(
        searchType: "searchType",
        expression: "expression",
        results: [],
        errorMessage: "",
      );
    }
  }
}
