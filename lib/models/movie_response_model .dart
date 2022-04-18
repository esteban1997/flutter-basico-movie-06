// ignore_for_file: file_names

import 'package:movies_06/models/movie_model.dart';

class MovieResponseModel {
  int page;
  List<MovieModel> movies;

  MovieResponseModel(this.page, this.movies);

  MovieResponseModel.fromJson(Map<String, dynamic> movieResponseMap)
      : page = movieResponseMap['page'],
        movies = List<MovieModel>.from(
            movieResponseMap['results'].map((m) => MovieModel.fromJson(m)));
}
