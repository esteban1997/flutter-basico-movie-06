// ignore_for_file: avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movies_06/models/movie_model.dart';
import 'package:movies_06/movies/detail_page.dart';
import 'package:movies_06/movies/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//final ThemeData theme = ThemeData();

  /*myRequest() async {
    final res = await HttpHelper.getPopular();
  }*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //myRequest();
    return MaterialApp(
        title: 'Peliculas',
        initialRoute: ListPage.ROUTE,
        //theme: theme.copyWith(font ,primaryColor: Colors.orange,colorScheme: theme.colorScheme.copyWith(secondary:Colors.red)),
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.red,
            fontFamily: 'Georgia',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
              bodyText1: TextStyle(fontSize: 14.0),
              bodyText2: TextStyle(fontStyle: FontStyle.italic),
            )),
        routes: {
          ListPage.ROUTE: (_) => ListPage(),
          DetailPage.ROUTE: (_) => DetailPage(
                movie: MovieModel.empty(),
              )
        });
  }
}
