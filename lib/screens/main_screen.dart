import 'package:anime_app/constants/app_textstyle.dart';
import '../models/anime_model.dart';

//import 'package:anime_app/presentation/widgets/vidoe_widget.dart';
import '../services/home_screen_api.dart';
import '../widgets/anime_listview_horizontal.dart';
import '../widgets/new_episodes.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomePageScrap pageScrap = HomePageScrap();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Anime App', style: TextStyle(fontSize: 25)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: FutureBuilder<HomePageModel>(
              future: pageScrap.extractData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "الانميات المثبتة",
                            style: ApptextStyle.BODY_TEXT,
                            textAlign: TextAlign.end,
                          ),
                          AnimeListViewH(
                              animeListModel: snapshot.data!.pinAnimes),
                          Text(
                            "الحلقات الجديدة",
                            style: ApptextStyle.BODY_TEXT,
                            textAlign: TextAlign.end,
                          ),
                          NewEpisodes(newEpisods: snapshot.data!.lastEpisodes)
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "${snapshot.error}",
                        style: ApptextStyle.BODY_TEXT,
                      ),
                    );
                  }
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ));
  }
}
