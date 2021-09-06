import '../constants/urls.dart';
import '../models/anime_model.dart';
import '../models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'dart:convert' show utf8;

class HomePageScrap {
  Future<HomePageModel> extractData() async {
    final res = await http.Client().get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      var animes = document.querySelector('div.anime-list-content');
      var episodesList = document.querySelector('.episodes-list-content > div');

      return HomePageModel(
        pinAnimes: _getAnime(animes!.children),
        lastEpisodes: _getEpisodes(episodesList!.children),
      );
      // animeSeason: _getAnime(animes[1].children));
    } else {
      throw Exception('Failed to load data');
    }
  }

  _getAnime(List<dom.Element> element) {
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

  _getEpisodes(List<dom.Element> element) {
    List<EpisodeModel> _lastEpisodes = [];
    element.forEach((el) {
      var imgE = el.querySelector('img')!;
      var urlE = el.querySelectorAll('a');

      _lastEpisodes.add(EpisodeModel(
          image: imgE.attributes['src']!,
          episodeNumber: urlE[4].text.replaceAll('\n', ''),
          url: urlE[0].attributes['href']!,
          animeName: urlE[3].text));
    });

    return _lastEpisodes;
  }
}
