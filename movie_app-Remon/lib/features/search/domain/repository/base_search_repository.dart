import '../../data/models/search_model.dart';

abstract class BaseSearchRepository {
  Future<SearchMovieResponse> searchMovie(String keyWord);
}