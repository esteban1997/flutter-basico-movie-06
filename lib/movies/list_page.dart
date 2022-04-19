// ignore_for_file: constant_identifier_names, avoid_unnecessary_containers, avoid_print, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:movies_06/helpers/custom_transition_route.dart';
import 'package:movies_06/helpers/http_helper.dart';
import 'package:movies_06/models/movie_response_model%20.dart';
import 'package:movies_06/movies/detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  static const String ROUTE = "/";

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MovieResponseModel movieResponse = MovieResponseModel.empty();

  ScrollController _scrollController = ScrollController();

  bool _loadData = false;

  Icon _barVisibleIcon = Icon(Icons.search);
  Widget _barSearch = Text("Listado de peliculas");

  @override
  void initState() {
    _dataList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              (_scrollController.position.maxScrollExtent - 50) &&
          !_loadData) {
        _dataList();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: _barSearch,
        actions: [
          IconButton(
              onPressed: () {
                if (_barVisibleIcon.icon == Icons.search) {
                  _barVisibleIcon = Icon(Icons.cancel);
                  _barSearch = TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: Colors.white),
                    onSubmitted: (text) {
                      movieResponse = MovieResponseModel.empty();
                      _dataList(text: text);
                    },
                  );
                } else {
                  movieResponse = MovieResponseModel.empty();
                  _barVisibleIcon = Icon(Icons.search);
                  _barSearch = Text("Listado de peliculas");

                  _dataList();
                }
                setState(() {});
              },
              icon: _barVisibleIcon)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: movieResponse.movies.length,
                  itemBuilder: (_, int position) {
                    var m = movieResponse.movies[position];
                    NetworkImage image;
                    if (m.posterPath == null) {
                      image = const NetworkImage(
                          'https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg');
                    } else {
                      image =
                          NetworkImage(HttpHelper.baseUrlImage + m.posterPath!);
                    }

                    return Card(
                        child: ListTile(
                      leading: Hero(
                        tag: "poster_${m.id}",
                        child: CircleAvatar(
                          backgroundImage: image,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        //navegacion por nombre
                        // Navigator.pushNamed(context, DetailPage.ROUTE,
                        //     arguments: m);

                        //navegacion por defecto
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return DetailPage(movie: m);
                        // }));

                        //navegacion con trasiciones
                        // Navigator.push(
                        //     context,
                        //     PageRouteBuilder(
                        //         pageBuilder: (_, Animation<double> animation,
                        //             Animation<double> animationSecondary) {
                        //           return DetailPage(movie: m);
                        //         },
                        //         transitionsBuilder: (_,
                        //             Animation<double> animation,
                        //             Animation<double> animationSecondary,
                        //             Widget child) {
                        //           return Align(
                        //             alignment: Alignment.bottomLeft,
                        //             child: SizeTransition(
                        //                 sizeFactor: animation, child: child),
                        //           );
                        //         },
                        //         transitionDuration: Duration(milliseconds: 500),
                        //         reverseTransitionDuration:
                        //             Duration(milliseconds: 500)
                        //             ),
                        //             );

                        // Navigator.push(context,
                        //     CustomFadeTransitionRoute(DetailPage(movie: m)));

                        Navigator.push(
                            context,
                            CustomTransitionRoute(
                                transitionType: TransitionType.slideLeft,
                                widget: DetailPage(
                                  movie: m,
                                )));
                      },
                      title: Hero(
                          tag: "title_${m.id}",
                          child: Text(
                            m.title,
                            style: Theme.of(context).textTheme.headline6,
                          )),
                      subtitle: Align(
                          alignment: Alignment.centerRight,
                          child: Hero(
                            tag: "date_${m.id}",
                            child: Text(
                              m.releaseDate,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          )),
                    ));
                  }),
            ),
            SizedBox(
              height: _loadData ? 20 : 0,
              width: 20,
              child: const CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  _dataList({String text = ""}) async {
    _loadData = true;
    setState(() {});
    final movieResponseAux = await (_barVisibleIcon.icon == Icons.search
        ? HttpHelper.getPopular(movieResponse.page)
        : HttpHelper.getSearch(movieResponse.page, text));

    _loadData = false;

    if (movieResponseAux != null && movieResponseAux.movies.isNotEmpty) {
      movieResponse.movies.addAll(movieResponseAux.movies);
      movieResponse.page++;
    }
    setState(() {});
  }
}
