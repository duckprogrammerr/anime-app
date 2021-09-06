import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/models/anime_model.dart';
import 'package:anime_app/services/anime_schedule_api.dart';
import 'package:anime_app/widgets/anime_listview_horizontal.dart';
import 'package:anime_app/widgets/anime_widget.dart';
import 'package:flutter/material.dart';

class AnimeSchedule extends StatefulWidget {
  AnimeSchedule({Key? key}) : super(key: key);

  @override
  _AnimeScheduleState createState() => _AnimeScheduleState();
}

class _AnimeScheduleState extends State<AnimeSchedule> {
  List<String> days = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<List<AnimeModel>>?>(
              future: ScheduleScrapPage().extractData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              days[index],
                              style: ApptextStyle.BODY_TEXT,
                            ),
                          ),
                          AnimeListViewH(
                            animeListModel: snapshot.data![index],
                          )
                        ],
                      ));
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
