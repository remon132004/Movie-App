import 'package:movie_app/features/home/domian/entities/date_model.dart';
import 'package:movie_app/core/utils/entities/movie_model.dart';

class NowPlayingResponse {
  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) {
    return NowPlayingResponse(
      dates: Dates.fromJson(json['dates']),
      page: json['page'],
      results: (json['results'] as List)
          .map((item) => Movie.fromJson(item))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}



