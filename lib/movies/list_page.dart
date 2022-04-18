// ignore_for_file: constant_identifier_names, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:movies_06/helpers/http_helper.dart';
import 'package:movies_06/models/movie_response_model%20.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  static const String ROUTE = "/";

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Widget>? widgetMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("texto listado")),
      body: Container(
        child: FutureBuilder(
            future: _dataList(),
            builder: (_, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                  itemCount: widgetMovies!.length,
                  itemBuilder: (_, int position) {
                    return widgetMovies![position];
                  });
            }),
      ),
    );
  }

  Future<List<Widget>?> _dataList() async {
    final MovieResponseModel? movieResponse = await HttpHelper.getPopular();
    print(movieResponse);

    var image;

    widgetMovies = movieResponse?.movies.map((m) {
      if (m.backdropPath == null) {
        //image = Image.network('https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg');
        image = NetworkImage(
            'https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg');
      } else {
        //image = Image.network(HttpHelper.baseUrlImage + m.posterPath!);
        image = NetworkImage(HttpHelper.baseUrlImage + m.posterPath!);
      }

      return Card(
        child: ListTile(
          //leading: image,
          leading: CircleAvatar(
            backgroundImage: image,
          ),
          title: Text(m.title),
        ),
      );
    }).toList();

    return widgetMovies;
  }
}
