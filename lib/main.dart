// ignore_for_file: avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movies_06/movies/detail_page.dart';
import 'package:movies_06/movies/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        routes: {
          ListPage.ROUTE: (_) => ListPage(),
          DetailPage.ROUTE: (_) => DetailPage()
        });
  }
}
