import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/screens/anime_screen.dart';
import '../models/anime_model.dart';
import 'package:flutter/material.dart';

class SearchAnimeContainerWidget extends StatelessWidget {
  final AnimeModel anime;
  SearchAnimeContainerWidget({required this.anime});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimeScreen(anime)),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              child: Image.network(
                anime.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    anime.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: ApptextStyle.MY_ANIME_TITLE,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(anime.season, style: ApptextStyle.MY_ANIME_SUBTITLE),
                    SizedBox(width: 20),
                    Text(anime.state, style: ApptextStyle.MY_ANIME_SUBTITLE),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
