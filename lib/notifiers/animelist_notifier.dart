import 'package:anime_app/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/models/anime_model.dart';

class AnimeListNotifier with ChangeNotifier {
  String url = animeListUrl;
  int page = 1;

  List<AnimeModel> animeList = [];
  addAnimeTolist(List<AnimeModel> _animeList) {
    animeList.addAll(_animeList);
    notifyListeners();
  }

  setAnimeList(List<AnimeModel> _animeList) {
    animeList = [];
    animeList = _animeList;
    notifyListeners();
  }

  setUrl(String _url) {
    url = _url;
    notifyListeners();
  }

  int setPage() {
    page = 1;
    notifyListeners();
    return page;
  }

  addPage() {
    page++;
    notifyListeners();
  }

  List<AnimeModel> getAnimeList() => animeList;
}
