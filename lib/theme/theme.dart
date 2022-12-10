import 'package:flutter/material.dart';
import 'package:imdb/main.dart';
import 'package:imdb/theme/colors/colors.dart';

class DesignWidget extends StatelessWidget {
  const DesignWidget({super.key, required this.themeMode});

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: imdbYellowColorM,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: const VisualDensity(
          horizontal: 2,
          vertical: 2,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: darkestColor),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: darkestColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: darkestColor,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: imdbYellowColor,
          foregroundColor: darkestColor,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 40,
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              Colors.black,
            ),
          ),
        ),
        dividerColor: darkColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: imdbYellowColorM,
        scaffoldBackgroundColor: darkColor,
        visualDensity: const VisualDensity(
          horizontal: 2,
          vertical: 2,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: imdbYellowColor,
          foregroundColor: darkestColor,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              Colors.white,
            ),
          ),
        ),
        dividerColor: imdbYellowColor,
      ),
      themeMode: themeMode,
      home: const MainPage(),
    );
  }
}
