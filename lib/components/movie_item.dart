import 'package:flutter/material.dart';
import 'package:imdb/screen/movie_detail/movie_detail_widget.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    this.date = "",
    this.click = true,
  });
  final String id;
  final String image;
  final String title;
  final String date;
  final bool click;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;
    String date = widget.date;
    double imgSize = .45;

    return SizedBox(
      width: width * imgSize,
      child: GestureDetector(
        onTap: () {
          if (widget.click) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailWidget(id: id),
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(imdbYellowColor),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  image: image,
                  placeholder: kTransparentImage,
                  width: width * imgSize,
                  height: ((width * imgSize) / 2) * 3,
                  imageSemanticLabel: title,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade700,
                      width: width * imgSize,
                      height: ((width * imgSize) / 2) * 3,
                      alignment: Alignment.center,
                      child: const Text(
                        "Image Not Found",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (date.isNotEmpty)
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: true,
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
