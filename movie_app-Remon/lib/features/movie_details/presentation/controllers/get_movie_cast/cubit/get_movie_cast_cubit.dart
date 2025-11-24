import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/movie_details/domain/enities/movie_cast_model.dart';


part 'get_movie_cast_state.dart';

class GetMovieCastCubit extends Cubit<GetMovieCastState> {
  GetMovieCastCubit() : super(GetMovieCastInitial());

  Future<void> getMovieCast({required int movieId}) async {
    emit(GetMovieCastLoading());

    try {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        headers: {
          'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTFjNzQ1NmY1ZDRmZTA0MThkOGZjNDc0NTA2Mjk5ZiIsIm5iZiI6MTc1NjI3ODY3Ny40NzUwMDAxLCJzdWIiOiI2OGFlYWY5NWJiN2U0YTk1MzJiMzcwMWEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.M7n6mVueLOUPzsOneXuck1Uof60TrukbeaBHMklVv1I"
        },
        contentType: 'application/json',
      );

      Dio dio = Dio(options);


      final response = await dio.get(
        '/movie/$movieId/credits',
        queryParameters: {'language': 'en-US'},
      );

      final data = MovieCastModel.fromJson(response.data);

      if (response.statusCode == 200) {
        emit(GetMovieCastSuccess(movieCastModel: data));
      }
    } catch (e) {
      emit(GetMovieCastFailure(e: e.toString()));
    }
  }
}