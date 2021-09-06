import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/models/anime_model.dart';
import 'package:anime_app/models/episode.dart';
import 'package:anime_app/screens/episode_screen.dart';
import 'package:anime_app/services/anime_screen_api.dart';
import 'package:anime_app/services/loacl_storage.dart';
import 'package:anime_app/widgets/anime_page_scetion1.dart';
import 'package:flutter/material.dart';

class AnimeScreen extends StatefulWidget {
  final AnimeModel animeModel;
  AnimeScreen(this.animeModel);
  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  final History secureStorage = History();
  Map<String, String> seenEpisodes = {};
  List<EpisodeModel> episodesList = [];

  @override
  void initState() {
    super.initState();

    AnimePageScrap()
        .extractData(widget.animeModel.url)
        .then((value) => setState(() => episodesList = value));
    secureStorage.readAllSecureData().then((value) => seenEpisodes = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.animeModel.name,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AnimeScetionOne(widget.animeModel),
            ListView.builder(
                itemBuilder: (context, index) {
                  return episodeW(
                    episodesList[index],
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: episodesList.length)
          ],
        ),
      )),
    );
  }

  Container episodeW(EpisodeModel episode) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Color(0xff333333),
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 2,
            blurRadius: 20,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              seenEpisodes[episode.episodeNumber] == 'seen'
                  ? IconButton(
                      onPressed: () async {
                        secureStorage.deleteSecureData(
                          episode.episodeNumber,
                        );

                        secureStorage.readAllSecureData().then(
                            (value) => setState(() => seenEpisodes = value));
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        size: 30,
                        color: Colors.red,
                      ))
                  : Container(),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 34,
                  color: Colors.green,
                ),
                onPressed: () async {
                  secureStorage.writeSecureData(episode.episodeNumber, 'seen');

                  secureStorage
                      .readAllSecureData()
                      .then((value) => setState(() => seenEpisodes = value));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EpiodeScreen(episode)),
                  );
                },
              )
            ],
          ),
          Expanded(
            child: Text(
              "${episode.episodeNumber}",
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              maxLines: 2,
              style: ApptextStyle.MY_ANIME_TITLE,
            ),
          ),
        ],
      ),
    );
  }
}
