// ignore_for_file: constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:movies_06/helpers/http_helper.dart';
import 'package:movies_06/models/movie_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_06/widgets/movies/horizontal_movies.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const ROUTE = "/detail";

  @override
  Widget build(BuildContext context) {
    MovieModel? movie =
        ModalRoute.of(context)!.settings.arguments as MovieModel;

    String pathFull, pathPosted;
    if (movie.backdropPath == null) {
      //image = Image.network('https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg');
      pathFull =
          'https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg';
    } else {
      pathFull = HttpHelper.baseUrlImage + movie.backdropPath!;
    }
    if (movie.backdropPath == null) {
      //image = Image.network('https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg');
      pathPosted =
          'https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg';
    } else {
      pathPosted = HttpHelper.baseUrlImage + movie.posterPath!;
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.network(pathFull),
          Card(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            pathPosted,
                            width: 60,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            RatingBar.builder(
                              itemCount: 5,
                              initialRating: movie.voteAverage / 2,
                              allowHalfRating: true,
                              itemSize: 20,
                              itemBuilder: (context, _) {
                                return const Icon(Icons.star,
                                    color: Colors.amber);
                              },
                              ignoreGestures: true,
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                                "Votos: " +
                                    (movie.voteAverage / 2).toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                    ),
                    // ignore: prefer_const_constructors
                    Padding(padding: EdgeInsets.all(20), child: Text("Top 16")),
                    FutureBuilder(
                      future: HttpHelper.getTop(),
                      builder: (_, AsyncSnapshot snapshot) {
                        print('snapshot 1');
                        print(snapshot);
                        if (snapshot.hasData) {
                          return HorizontalMovies(
                            movieResponseModel: snapshot.data,
                          );
                        } else {
                          return const Text("errors");
                        }
                      },
                    )
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
