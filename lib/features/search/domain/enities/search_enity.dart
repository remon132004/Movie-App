// Entity for SearchMovieResponse
import 'package:movie_app/core/utils/entities/movie_model.dart';

class SearchMovieResponseEntity {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const SearchMovieResponseEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}

