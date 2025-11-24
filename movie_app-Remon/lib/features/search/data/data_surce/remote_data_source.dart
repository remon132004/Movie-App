import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:movie_app/main.dart';

class SearchRemoteDataSource {
  final Dio dio = Dio();
  final currentContext = navigatorKey.currentContext;

  Future<SearchMovieResponse> searchMovie(String keyWord) async {
    String language = currentContext?.locale == Locale('ar') ? 'ar' : 'en';
    try {
      var response = await dio.get(
          'https://api.themoviedb.org/3/search/movie?include_adult=false&language=$language&page=1&query=$keyWord',
          options: Options(headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTFjNzQ1NmY1ZDRmZTA0MThkOGZjNDc0NTA2Mjk5ZiIsIm5iZiI6MTc1NjI3ODY3Ny40NzUwMDAxLCJzdWIiOiI2OGFlYWY5NWJiN2U0YTk1MzJiMzcwMWEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.M7n6mVueLOUPzsOneXuck1Uof60TrukbeaBHMklVv1I",
            "accept": "application/json"
          }));
      if (response.statusCode == 200) {
        return SearchMovieResponse.fromJson(response.data);
      }
      throw Exception('no data');
    } catch (e) {
      throw e;
    }
  }
}
