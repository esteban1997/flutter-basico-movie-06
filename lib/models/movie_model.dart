import 'package:movies_06/helpers/http_helper.dart';

class MovieModel {
  int id;
  String? backdropPath;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  MovieModel(
      {required this.id,
      required this.backdropPath,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.voteCount});

  getImagePoster() {
    if (posterPath == null) {
      return 'https://st.depositphotos.com/1027431/2529/i/950/depositphotos_25299009-stock-photo-white-silk-background.jpg';
    }

    return HttpHelper.baseUrlImage + posterPath!;
  }

  MovieModel.fromJson(Map<String, dynamic> movieMap)
      : id = movieMap['id'] ?? "",
        backdropPath = movieMap['backdrop_path'] ?? "",
        originalLanguage = movieMap['original_language'] ?? "",
        originalTitle = movieMap['original_title'] ?? "",
        overview = movieMap['overview'] ?? "",
        popularity = movieMap['popularity'] ?? "",
        posterPath = movieMap['poster_path'] ?? "",
        releaseDate = movieMap['release_date'] ?? "",
        title = movieMap['title'] ?? "",
        voteAverage = double.parse(movieMap['vote_average'].toString()),
        voteCount = movieMap['vote_count'] ?? "";
}
