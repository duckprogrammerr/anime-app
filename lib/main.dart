import 'package:anime_app/notifiers/animelist_notifier.dart';
import 'package:anime_app/services/loacl_storage.dart';
import 'package:provider/provider.dart';
import 'screens/anime_schedule_screen.dart';
import 'screens/anime_series_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AnimeListNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String themeS = '';
  int _selectedIndex = 1;
  List<Widget> screens = [
    AnimeSeries(),
    MainScreen(),
    AnimeSchedule(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AnimeApp',
        theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            ),
            // ignore: unrelated_type_equality_checks
            brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: ConvexAppBar(
            //  cornerRadius: 10.0,
            backgroundColor: Colors.black45,
            color: Colors.white,

            items: [
              TabItem(
                icon: Icons.video_library_outlined,
              ),
              TabItem(
                icon: Icons.home,
              ),
              TabItem(
                icon: Icons.date_range,
              ),
            ],

            initialActiveIndex: _selectedIndex,
            onTap: (int v) => setState(() {
              _selectedIndex = v;
            }),
          ),
          body: screens[_selectedIndex],
        ));
  }
}
