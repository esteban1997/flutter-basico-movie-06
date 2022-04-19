// ignore_for_file: file_names

import 'package:movies_06/models/movie_model.dart';

class MovieResponseModel {
  late int page;
  late List<MovieModel> movies;

  MovieResponseModel(this.page, this.movies);

  MovieResponseModel.empty() {
    movies = [];
    page = 1;
  }

  MovieResponseModel.fromJson(Map<String, dynamic> movieResponseMap)
      : page = movieResponseMap['page'],
        movies = List<MovieModel>.from(
            movieResponseMap['results'].map((m) => MovieModel.fromJson(m)));
}
