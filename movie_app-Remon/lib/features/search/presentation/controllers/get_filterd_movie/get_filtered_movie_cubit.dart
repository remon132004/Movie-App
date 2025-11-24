import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import 'package:movie_app/features/search/data/repository/search_repository_implementaion.dart';
import 'package:movie_app/features/search/domain/enities/search_enity.dart';
import 'package:movie_app/features/search/domain/repository/base_search_repository.dart';

part 'get_filtered_movie_state.dart';

class GetFilteredMovieCubit extends Cubit<GetFilteredMovieState> {
  GetFilteredMovieCubit() : super(GetFilteredMovieInitial());
  final BaseSearchRepository baseSearchRepository =
      SearchRepositoryImplementation();

  Future<void> getFilterdMovie(String keyWord) async {
    emit(GetFilteredMovieLoading());
    try {
      SearchMovieResponseEntity res =
          await baseSearchRepository.searchMovie(keyWord);
      if(res.results.isNotEmpty){
        print(res.results.length);
        emit(GetFilteredMovieSuccess(res));
      }else{
        emit(GetFilteredMovieInitial());
      }
    } catch (e) {
      emit(GetFilteredMovieFailure(e.toString()));
    }
  }
}
