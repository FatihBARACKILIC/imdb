import 'package:flutter/material.dart';
import 'package:imdb/helper/shared_preferences_helper.dart';
import 'package:imdb/main.dart';
import 'package:imdb/theme/colors/colors.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  int _selectedMode = 0;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: FittedBox(
                  child: Text(
                    "Theme",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _lightMode,
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(darkColor),
                          shape: MaterialStatePropertyAll(
                            CircleBorder(
                              side: BorderSide(
                                  color: _selectedMode == 1
                                      ? imdbYellowColor
                                      : Colors.white,
                                  width: 2),
                            ),
                          ),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(20)),
                        ),
                        child: const Icon(
                          Icons.light_mode,
                          size: 50,
                          color: imdbYellowColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _darkMode,
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(darkColor),
                          shape: MaterialStatePropertyAll(
                            CircleBorder(
                              side: BorderSide(
                                  color: _selectedMode == 2
                                      ? imdbYellowColor
                                      : Colors.white,
                                  width: 2),
                            ),
                          ),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(20)),
                        ),
                        child: const Icon(
                          Icons.dark_mode,
                          size: 50,
                          color: imdbYellowColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        16, 16, 16, MediaQuery.of(context).size.height * .1),
                    child: const Text(
                      "Select your theme. if you don't we are going to use your system defaults.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _lightMode() {
    setState(() {
      _selectedMode = 1;
      if (IMDbApp.themeNotifier.value != ThemeMode.light) {
        SharedPreferencesHelper.setSharedPreferences("darkMode", false);
        IMDbApp.themeNotifier.value = ThemeMode.light;
      }
    });
  }

  void _darkMode() {
    setState(() {
      _selectedMode = 2;
      if (IMDbApp.themeNotifier.value != ThemeMode.dark) {
        SharedPreferencesHelper.setSharedPreferences("darkMode", true);
        IMDbApp.themeNotifier.value = ThemeMode.dark;
      }
    });
  }
}
