import 'package:flutter/material.dart';
import 'package:imdb/constant/languages.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/theme/colors/colors.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List _language = [];
  String _selectedLanguage = "en";

  @override
  void initState() {
    super.initState();
    setState(() {
      _language = Languages.languages;
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: const FittedBox(
                  child: Icon(
                    Icons.translate,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: FittedBox(
                  child: Text(
                    "Select Your Language",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  isExpanded: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.grey.shade900,
                  menuMaxHeight: MediaQuery.of(context).size.height * .2,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value ?? "en";
                      SharedPreferencesHelper.setSharedPreferences(
                          "selectedLanguage", _selectedLanguage);
                    });
                  },
                  items: _language.map<DropdownMenuItem<String>>(
                    (value) {
                      return DropdownMenuItem<String>(
                        value: value[0],
                        child: Text(value[1]),
                      );
                    },
                  ).toList(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Please select your language and we will translate summaries for you.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _language.firstWhere(
                      (element) => element[0] == _selectedLanguage)[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
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
