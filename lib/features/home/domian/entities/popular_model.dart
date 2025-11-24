import 'package:movie_app/core/utils/entities/movie_model.dart';


class PopularModel {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  PopularModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    return PopularModel(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  PopularModel removeMovieById(int movieId) {
    return PopularModel(
      page: page,
      results: results.where((movie) => movie.id != movieId).toList(),
      totalPages: totalPages,
      totalResults: totalResults - 1,
    );
  }
}
