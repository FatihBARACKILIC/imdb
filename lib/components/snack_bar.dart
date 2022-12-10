import 'package:flutter/material.dart';
import 'package:imdb/theme/colors/colors.dart';

class ShowSnackBar {
  ShowSnackBar(
      {required BuildContext context,
      required var content,
      bool isOkey = true}) {
    ScaffoldMessenger.of(context).showSnackBar(createSnackBar(content, isOkey));
  }

  SnackBar createSnackBar(
    var content,
    bool isOkey,
  ) {
    return SnackBar(
      content: Text(
        "$content",
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isOkey ? purpleColor : Colors.red,
    );
  }
}
