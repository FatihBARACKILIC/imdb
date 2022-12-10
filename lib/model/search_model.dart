import 'dart:convert';
import 'package:imdb/model/result_model.dart';

SearchModel searchFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.searchType,
    required this.expression,
    required this.results,
    required this.errorMessage,
  });

  String searchType;
  String expression;
  List<ResultModel> results;
  String errorMessage;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        searchType: json["searchType"],
        expression: json["expression"],
        results: List<ResultModel>.from(
            json["results"].map((e) => ResultModel.fromJson(e))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "searchType": searchType,
        "expression": expression,
        "results": List<dynamic>.from(results.map((e) => e.toJson())),
        "errorMessage": errorMessage,
      };
}
