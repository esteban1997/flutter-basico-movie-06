// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:movies_06/models/movie_response_model%20.dart';
import 'package:movies_06/movies/detail_page.dart';

class HorizontalMovies extends StatelessWidget {
  final MovieResponseModel movieResponseModel;

  const HorizontalMovies({
    required this.movieResponseModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieResponseModel.movies.length,
          itemBuilder: (_, int position) {
            var m = movieResponseModel.movies[position];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DetailPage.ROUTE,
                            arguments: movieResponseModel.movies[position]);
                      },
                      child: Image.network(m.getImagePoster()))),
            );
          }),
    );
  }
}
