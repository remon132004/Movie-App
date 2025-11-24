import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/home/domian/entities/upcoming_model.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());

  Future<void> getUpComing() async {
    emit(UpcomingLoading());
    Dio dio = Dio();
    try{
      
      var response = await dio.get(
          'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1',
          options: Options(headers: {
            "Authorization":
                " Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMDdmYzkwZGM3MjM0MzI3OTUzYzgyNDRmYzBmMTkzNyIsIm5iZiI6MTc1NzYxMTY3NS4zMDIsInN1YiI6IjY4YzMwNjliYTA0YzIyZmI5Nzk0OGQzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.v3surX_XHDA0fJTTBuAwtSWV04NUhbuy66VHmrEnEEM",
            "accept": "application/json",
          }));
      var data = UpcomingModel.fromJson(response.data);
      
      if(response.statusCode == 200){
        
        emit(UpcomingSuccess(data));
      }
    }catch(e){
      emit(UpcomingFailure(e.toString()));
    }
  }
}
