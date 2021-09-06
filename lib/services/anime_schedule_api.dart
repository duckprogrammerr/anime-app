import 'package:anime_app/constants/urls.dart';

import '../models/anime_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'dart:convert' show utf8;

class ScheduleScrapPage {
  Future<List<List<AnimeModel>>?> extractData() async {
    final res = await http.Client().get(Uri.parse(schedule));
    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      var animes = document.querySelectorAll('div.anime-list-content');
      List<List<AnimeModel>> anime = [];

      animes.forEach((ele) {
        anime.add(getAnime(ele.children[0].children));
      });
      return anime;
    } else {
      throw Exception("Faild To Get Data");
    }
  }

  List<AnimeModel> getAnime(List<dom.Element> element) {
    List<AnimeModel> _animeList = [];
    element.forEach((el) {
      var imgE = el.querySelector('img')!;
      var urlE = el.querySelectorAll('div.anime-card-container a');
      var story = el.querySelector('div.anime-card-title');
      _animeList.add(AnimeModel(
        name: imgE.attributes['alt']!.replaceAll('-', ' '),
        image: imgE.attributes['src']!,
        url: urlE[0].attributes['href']!,
        state: urlE[2].text,
        story: story!.attributes['data-content']!,
        season: urlE[4].text,
      ));
    });

    return _animeList;
  }
}
