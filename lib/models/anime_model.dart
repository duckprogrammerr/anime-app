import 'episode.dart';

class HomePageModel {
  late final List<AnimeModel> pinAnimes;
  late final List<EpisodeModel> lastEpisodes;
  HomePageModel({
    required this.pinAnimes,
    required this.lastEpisodes,
  });

  HomePageModel.fromJson(Map<String, dynamic> json) {
    pinAnimes = json['pinAnimes'];
    lastEpisodes = json['lastEpisodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pinAnimes'] = this.pinAnimes;
    data['lastEpisodes'] = this.lastEpisodes;
    return data;
  }
}

class AnimeModel {
  late String name;
  late String image;
  late String state;
  late String season;
  late String story;
  late String url;

  AnimeModel(
      {required this.name,
      required this.image,
      required this.state,
      required this.season,
      required this.story,
      required this.url});

  AnimeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    state = json['state'];
    season = json['season'];
    story = json['story'];

    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['state'] = this.state;
    data['season'] = this.season;
    data['story'] = this.story;
    data['url'] = this.url;
    return data;
  }
}
