import 'package:anime_app/screens/episode_screen.dart';
import 'package:anime_app/services/loacl_storage.dart';

import '../constants/app_textstyle.dart';
import '../models/episode.dart';
import 'package:flutter/material.dart';

class NewEpisodes extends StatelessWidget {
  final List<EpisodeModel> newEpisods;
  NewEpisodes({required this.newEpisods});

  @override
  Widget build(BuildContext context) {
    final History secureStorage = History();
    return ListView.separated(
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            secureStorage.writeSecureData(newEpisods[i].episodeNumber, 'seen');

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EpiodeScreen(newEpisods[i])),
            );
          },
          splashColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      newEpisods[i].animeName!,
                      style: ApptextStyle.MY_ANIME_TITLE,
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      newEpisods[i].episodeNumber,
                      style: ApptextStyle.MY_ANIME_SUBTITLE,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Image.network(
                newEpisods[i].image!,
                fit: BoxFit.cover,
                width: 150,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, i) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: newEpisods.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
