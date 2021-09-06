import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/constants/colors.dart';
import 'package:anime_app/models/anime_model.dart';
import 'package:anime_app/widgets/story_dialog.dart';
import 'package:flutter/material.dart';

class AnimeScetionOne extends StatelessWidget {
  final AnimeModel animeModel;
  AnimeScetionOne(this.animeModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  animeModel.name,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
                Text(
                  "الحالة: ${animeModel.state}",
                  style: ApptextStyle.MY_ANIME_SUBTITLE,
                ),
                Text(
                  "الناريخ: ${animeModel.season}",
                  style: ApptextStyle.MY_ANIME_SUBTITLE,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.article,
                          color: Colors.orange[300],
                          size: 26,
                        ),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AdvanceCustomAlert(animeModel.story))),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Image.network(
            animeModel.image,
            width: 130,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
