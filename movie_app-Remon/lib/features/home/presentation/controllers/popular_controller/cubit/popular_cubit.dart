import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/home/domian/entities/popular_model.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());
  Future<void> getPopular() async {
    emit(PopularLoading());
    Dio dio = Dio();

    try {
      var response = await dio.get(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1',
          options: Options(headers: {
            "Authorization":
                " Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMDdmYzkwZGM3MjM0MzI3OTUzYzgyNDRmYzBmMTkzNyIsIm5iZiI6MTc1NzYxMTY3NS4zMDIsInN1YiI6IjY4YzMwNjliYTA0YzIyZmI5Nzk0OGQzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.v3surX_XHDA0fJTTBuAwtSWV04NUhbuy66VHmrEnEEM",
            "accept": "application/json",
          }));

      var data = PopularModel.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(PopularSuccess(data));
      }
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }
}
