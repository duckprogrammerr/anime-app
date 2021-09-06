import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/models/episode.dart';
import 'package:anime_app/services/episode_screen_api.dart';
import 'package:anime_app/widgets/vidoe_widget.dart';

import 'package:flutter/material.dart';

class EpiodeScreen extends StatefulWidget {
  final EpisodeModel episodeModel;
  EpiodeScreen(this.episodeModel);

  @override
  _EpiodeScreenState createState() => _EpiodeScreenState();
}

class _EpiodeScreenState extends State<EpiodeScreen> {
  EpisodePageScrap _scrap = EpisodePageScrap();
  List<Map<String, String>> videosUrls = [];
  String videoUrl = '';

  int selectedServer = 0;
  Future getServers() async {
    var res = await _scrap.extractData(widget.episodeModel.url);

    setState(() => videosUrls = res);
  }

  @override
  void initState() {
    super.initState();
    getServers().whenComplete(() => _scrap
        .checkTheUrl(videosUrls[0]['videoUrl']!)
        .then((value) => setState(() => videoUrl = value!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.episodeModel.episodeNumber,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: videosUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var videoU = await _scrap
                            .checkTheUrl(videosUrls[index]['videoUrl']!);
                        setState(() {
                          videoUrl = videoU!;
                          selectedServer = index;
                        });
                      },
                      child: Text(videosUrls[index]['name']!),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              selectedServer == index
                                  ? Colors.blue[700]
                                  : Colors.blue)),
                    ),
                  );
                },
              ),
            ),
            videoUrl == 'no video url'
                ? Align(
                    child: Text(
                      'Change The  Server !',
                      style: ApptextStyle.BODY_TEXT,
                    ),
                    alignment: Alignment.center,
                  )
                : Center(
                    child: Container(
                        child: VideoDisplay(videoUrl: videoUrl), height: 400),
                  ),
          ],
        ),
      )),
    );
  }
}
