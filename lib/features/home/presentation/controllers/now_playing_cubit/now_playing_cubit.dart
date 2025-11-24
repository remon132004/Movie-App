import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/home/domian/entities/now_playing_model.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());

  Future<void> getNowPlaying() async {
    emit(NowPlayingLoading());
    Dio dio = Dio();

    try {
      var res = await dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1',
          options: Options(headers: {
            "Authorization":
                " Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMDdmYzkwZGM3MjM0MzI3OTUzYzgyNDRmYzBmMTkzNyIsIm5iZiI6MTc1NzYxMTY3NS4zMDIsInN1YiI6IjY4YzMwNjliYTA0YzIyZmI5Nzk0OGQzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.v3surX_XHDA0fJTTBuAwtSWV04NUhbuy66VHmrEnEEM",
            "accept": "application/json",
          }));

      if (res.statusCode == 200) {
        emit(NowPlayingSuccess(NowPlayingResponse.fromJson(res.data)));
      }
    } catch (e) {
      emit(NowPlayingFailure(e.toString()));
    }
  }
}
