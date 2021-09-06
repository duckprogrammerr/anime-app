import 'package:anime_app/models/anime_model.dart';
import 'package:anime_app/widgets/search_anime_widget.dart';
import 'package:flutter/material.dart';

class AnimeSeriesListView extends StatefulWidget {
  final List<AnimeModel> animeList;
  AnimeSeriesListView(
    this.animeList,
  );
  @override
  _AnimeSeriesListViewState createState() => _AnimeSeriesListViewState();
}

class _AnimeSeriesListViewState extends State<AnimeSeriesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, i) {
        return SearchAnimeContainerWidget(anime: widget.animeList[i]);
      },
      cacheExtent: 10.0,
      itemCount: widget.animeList.length,
    );
  }
}
