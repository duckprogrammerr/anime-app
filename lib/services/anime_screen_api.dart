import '../models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:convert' show utf8;

class AnimePageScrap {
  Future<List<EpisodeModel>> extractData(String animeUrl) async {
    final res = await http.Client().get(Uri.parse(animeUrl));
    List<EpisodeModel> episodes = [];
    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      document.querySelectorAll('.episodes-card').forEach((element) {
        episodes.add(EpisodeModel(
            episodeNumber: element
                .querySelector('img')!
                .attributes['alt']!
                .replaceAll('-', ' '),
            url: element.querySelector('a')!.attributes['href']!));
      });
      return episodes;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
