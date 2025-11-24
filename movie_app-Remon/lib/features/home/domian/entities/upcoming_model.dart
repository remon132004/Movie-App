import 'package:movie_app/features/home/domian/entities/date_model.dart';
import 'package:movie_app/core/utils/entities/movie_model.dart';
import 'package:movie_app/features/home/domian/entities/now_playing_model.dart';

class UpcomingModel {
  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  UpcomingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      dates: Dates.fromJson(json['dates']),
      page: json['page'],
      results:
      (json['results'] as List).map((e) => Movie.fromJson(e)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }


}

