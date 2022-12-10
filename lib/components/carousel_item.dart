import 'package:flutter/material.dart';
import 'package:imdb/screen/movie_detail/movie_detail_widget.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselItem extends StatefulWidget {
  const CarouselItem({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.index,
    this.click = true,
  });
  final String id;
  final String image;
  final String title;
  final bool click;
  final int index;

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    String image = widget.image;
    String title = widget.title;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 20),
      width: 200,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                Container(
                  width: 160,
                  height: 240,
                  alignment: Alignment.center,
                  color: darkestColor,
                  child: Text(
                    widget.index.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  image: image,
                  placeholder: kTransparentImage,
                  width: 160,
                  height: 240,
                  imageSemanticLabel: title,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade700,
                      width: 160,
                      height: 240,
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
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 50,
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                softWrap: true,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
