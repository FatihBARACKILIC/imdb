import 'dart:io';
import 'package:dio/dio.dart';
import 'package:imdb/model/translate_model.dart';

class TranslateService {
  Future translate(String text, String lang) async {
    String key = "<Your translate api key>";

    try {
      var dio = Dio();

      final response = await dio.post(
        'https://google-translate1.p.rapidapi.com/language/translate/v2',
        data: {'q': text, 'target': lang, 'source': 'en'},
        options: Options(
          headers: {
            'content-type': 'application/x-www-form-urlencoded',
            'Accept-Encoding': 'application/json',
            'x-rapidapi-key': key,
            'x-rapidapi-host': 'google-translate1.p.rapidapi.com'
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        return TranslateModel.fromJson(
          response.data,
        ).data.translations[0].translatedText;
      } else {
        return "${response.statusCode}-${response.statusMessage}\nApi Error!";
      }
    } catch (e) {
      return "You used all available quotas!";
    }
  }
}
