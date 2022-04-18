// ignore_for_file: avoid_print, prefer_const_declarations

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies_06/models/movie_response_model%20.dart';

class HttpHelper {
  static final String key = '?api_key=266c496f8dd842caa0430351554f0b4a';
  static final String url = 'https://api.themoviedb.org/3/movie/';
  static final String baseUrlImage = 'https://image.tmdb.org/t/p/w500';

  static Future<MovieResponseModel?> getPopular() async {
    final res =
        await http.get(Uri.parse(HttpHelper.url + 'popular' + HttpHelper.key));
    print(Uri.parse(HttpHelper.url + 'popular' + HttpHelper.key));
    if (res.statusCode == HttpStatus.ok) {
      final jsonMap = json.decode(res.body);
      final MovieResponseModel movieResponse =
          MovieResponseModel.fromJson(jsonMap);
      return movieResponse;
    } else {
      return null;
    }
  }
}
