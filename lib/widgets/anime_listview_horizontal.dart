import '../models/anime_model.dart';
import 'package:flutter/material.dart';
import 'anime_widget.dart';

class AnimeListViewH extends StatelessWidget {
  final List<AnimeModel> animeListModel;
  AnimeListViewH({required this.animeListModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return AnimeWidget(
            animeListModel[index],
          );
        },
        separatorBuilder: (ctx, i) {
          return SizedBox(
            width: 15,
          );
        },
        itemCount: animeListModel.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
