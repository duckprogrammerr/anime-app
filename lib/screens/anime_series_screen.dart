import 'package:anime_app/constants/app_textstyle.dart';
import 'package:anime_app/constants/urls.dart';
import 'package:anime_app/notifiers/animelist_notifier.dart';
import 'package:anime_app/widgets/anime_series_listview.dart';
import 'package:provider/provider.dart';
import '../services/search_screen_api.dart';
import '../models/dropdown_model.dart';
import 'package:flutter/material.dart';

class AnimeSeries extends StatefulWidget {
  AnimeSeries({Key? key}) : super(key: key);
  @override
  _AnimeSeriesState createState() => _AnimeSeriesState();
}

class _AnimeSeriesState extends State<AnimeSeries> {
  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  SearchPageScrap _scrap = SearchPageScrap();
  List<List<AnimeType>> animeTypes = [];

  AnimeType? selectedItem;

  @override
  void initState() {
    super.initState();
    AnimeListNotifier animeListNotifier =
        Provider.of<AnimeListNotifier>(context, listen: false);
    _scrap.getAnimeTypes().then((v) => animeTypes = v);
    _scrap
        .extractData('$animeListUrl')
        .then((v) => animeListNotifier.setAnimeList(v));
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          animeListNotifier.addPage();
          if (animeListNotifier.url.contains('/?s=')) {
            _scrap
                .extractData(
                    '${animeListNotifier.url}&page=${animeListNotifier.page}')
                .then((value) {
              animeListNotifier.addAnimeTolist(value);
            });
          } else {
            _scrap
                .extractData(
                    '${animeListNotifier.url}?page=${animeListNotifier.page}')
                .then((value) {
              animeListNotifier.addAnimeTolist(value);
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AnimeListNotifier animeListNotifier =
        Provider.of<AnimeListNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Search',
          style: TextStyle(fontSize: 25),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: searchController,
                    onEditingComplete: () {
                      if (searchController.text != '') {
                        setState(() {
                          selectedItem = null;
                        });
                        animeListNotifier.setPage();
                        animeListNotifier.setUrl(
                            '$searchUrl${searchController.text.replaceAll(' ', '+')}');
                        _scrap.extractData(animeListNotifier.url).then(
                            (value) => animeListNotifier.setAnimeList(value));
                      } else {
                        animeListNotifier.setUrl(animeListUrl);
                        _scrap.extractData('$animeListUrl').then(
                            (value) => animeListNotifier.setAnimeList(value));
                      }
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Anime Name",
                      prefixIcon: Icon(Icons.search),
                      fillColor: Color(0xff444444),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            BorderSide(color: Color(0xff444444), width: 2),
                      ),
                    ),
                  ),
                ),
                selectedButton(),
                searchController.text == ''
                    ? Column(
                        children: animeTypes
                            .map((el) => animeTypeSection(el))
                            .toList(),
                      )
                    : Container(),
                AnimeSeriesListView(
                  animeListNotifier.getAnimeList(),
                )
              ],
            )),
      ),
    );
  }

  Widget selectedButton() {
    AnimeListNotifier animeListNotifier =
        Provider.of<AnimeListNotifier>(context);

    if (selectedItem != null) {
      return ElevatedButton.icon(
        onPressed: () {
          _scrap
              .extractData('$animeListUrl')
              .then((value) => animeListNotifier.setAnimeList(value));
          setState(() {
            selectedItem = null;
          });
        },
        icon: Icon(
          Icons.highlight_off,
          size: 25,
        ),
        label: Text(selectedItem!.name),
        style: ApptextStyle.BUTTON_STYLE,
      );
    } else {
      return Container();
    }
  }

  Container animeTypeSection(List<AnimeType> item) {
    AnimeListNotifier animeListNotifier =
        Provider.of<AnimeListNotifier>(context);
    return Container(
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              child: Text(
                item[index].name,
                style: ApptextStyle.MY_ANIME_TITLE,
              ),
              style: ApptextStyle.BUTTON_STYLE,
              onPressed: () {
                animeListNotifier.setUrl(item[index].url);
                animeListNotifier.setPage();
                _scrap
                    .extractData(item[index].url)
                    .then((value) => animeListNotifier.setAnimeList(value));
                setState(() {
                  selectedItem = item[index];
                });
              },
            ),
          );
        },
        itemCount: item.length,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
