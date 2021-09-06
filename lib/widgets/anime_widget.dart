import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/models/anime_model.dart';
import 'package:anime_app/screens/anime_screen.dart';
import 'package:flutter/material.dart';

class AnimeWidget extends StatelessWidget {
  final AnimeModel animeModel;
  AnimeWidget(this.animeModel);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnimeScreen(animeModel)),
        );
      },
      child: Container(
        width: 185,
        height: 280,
        decoration: BoxDecoration(
          color: Color(0xff333333),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.2), //Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // anime image section

            ClipRRect(
              child: Image.network(
                animeModel.image,
                fit: BoxFit.fill,
                width: 185,
                height: 140,
              ),
              borderRadius: BorderRadius.circular(7),
            ),

            Padding(
              padding: EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 65,
                    child: Text(
                      " ${animeModel.name} ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xffDDDDDD),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff4B6587),
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        child: Text(
                          " ${animeModel.season} ",
                          style: ApptextStyle.MY_ANIME_SUBTITLE,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff4B6587),
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        child: Text(
                          " ${animeModel.state} ",
                          style: ApptextStyle.MY_ANIME_SUBTITLE,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) // anime info section
          ],
        ),
      ),
    );
  }
}
