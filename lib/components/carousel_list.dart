import 'package:flutter/material.dart';
import 'package:imdb/components/carousel_item.dart';

class CarouselList extends StatefulWidget {
  const CarouselList({super.key, required this.data, this.click = true});
  final List data;
  final bool click;

  @override
  State<CarouselList> createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  int _pageCount = 10;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < (50 - _pageCount > 9 ? _pageCount : 50); i++)
            CarouselItem(
              id: widget.data[i].id,
              image:
                  "https://m.media-amazon.${widget.data[i].image.split(".")[2]}._V1_Ratio0.6762_AL_.jpg",
              title: widget.data[i].title,
              index: i + 1,
            ),
          if (50 > _pageCount)
            SizedBox(
              height: 300,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _pageCount += 10;
                  });
                },
                child: const Icon(Icons.add),
              ),
            ),
        ],
      ),
    );
  }
}
