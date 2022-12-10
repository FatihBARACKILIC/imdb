import 'package:flutter/material.dart';

class TitleAndText extends StatelessWidget {
  const TitleAndText({
    super.key,
    required this.title,
    required this.text,
  });
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: text,
            ),
          ],
          style: TextStyle(
            color: Colors.black,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
        ),
      ),
    );
  }
}
