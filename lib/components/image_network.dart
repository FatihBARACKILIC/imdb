import 'package:flutter/material.dart';
import 'package:imdb/theme/colors/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageNetwork extends StatefulWidget {
  const ImageNetwork({super.key, required this.imageURL});
  final String imageURL;

  @override
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(imdbYellowColor),
          ),
        ),
        FadeInImage.memoryNetwork(
          image: widget.imageURL,
          placeholder: kTransparentImage,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
