import 'package:anime_app/constants/urls.dart';
import '../models/anime_model.dart';
import '../models/dropdown_model.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'dart:convert' show utf8;

class SearchPageScrap {
  Future<List<List<AnimeType>>> getAnimeTypes() async {
    final res = await http.Client().get(Uri.parse('$animeListUrl'));

    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      var _drop = document.querySelectorAll('div.dropdown');
      List<List<AnimeType>> _d = [];

      for (var i = 0; i < _drop.length; i++) {
        _d.add(_drop[i]
            .querySelectorAll('a')
            .map((e) => AnimeType(name: e.text, url: e.attributes['href']!))
            .toList());
      }

      return _d;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<AnimeModel>> extractData(String url) async {
    final res = await http.Client().get(Uri.parse(url));
    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      var animes = document.querySelector('div.anime-list-content');
      return _getAnime(animes!.children[0].children);
    } else {
      throw Exception("Faild To Get Data");
    }
  }

  List<AnimeModel> _getAnime(List<dom.Element> element) {
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
