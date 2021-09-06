import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'dart:convert' show utf8;

class EpisodePageScrap {
  Future<List<Map<String, String>>> extractData(String episodesUrl) async {
    final res = await http.Client().get(Uri.parse(episodesUrl));

    if (res.statusCode == 200) {
      var document = parser.parse(utf8.decode(res.bodyBytes));
      var videosUrl = document.querySelectorAll('.watch > a');
      var v = await getVideoUrl(videosUrl);
      return v;
    } else {
      throw Exception('Failed to load data');
    }
  }

  getVideoUrl(List<dom.Element> urls) {
    List<Map<String, String>> videos = [];
    urls.forEach((el) => videos
        .add({'name': el.text, 'videoUrl': el.attributes['data-ep-url']!}));
    return videos;
  }

  Future<String?> checkTheUrl(String url) async {
    try {
      final res = await http.Client().get(Uri.parse(url));

      if (res.statusCode == 200) {
        var document = parser.parse(utf8.decode(res.bodyBytes));
        String? mp4url =
            document.querySelector('video > source')!.attributes['src'];

        return mp4url;
      } else {
        throw Exception('the url is Faild');
      }
    } catch (e) {
      return 'no video url';
    }
  }
}
