import 'package:movie_app/features/search/data/data_surce/remote_data_source.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:movie_app/features/search/domain/repository/base_search_repository.dart';

class SearchRepositoryImplementation  extends BaseSearchRepository{
  SearchRemoteDataSource searchRemoteDataSource = SearchRemoteDataSource();


  @override
  Future<SearchMovieResponse> searchMovie(String keyWord) {
    return searchRemoteDataSource.searchMovie(keyWord);

  }

}