class EpisodeModel {
  late String episodeNumber;
  late String? image;
  late String url;
  late String? animeName;

  EpisodeModel(
      {required this.episodeNumber,
      this.image,
      required this.url,
      this.animeName});

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    episodeNumber = json['episodeNumber'];
    image = json['image'];
    url = json['url'];
    animeName = json['animeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episodeNumber'] = this.episodeNumber;

    data['image'] = this.image;
    data['url'] = this.url;
    data['animeName'] = this.animeName;
    return data;
  }
}
