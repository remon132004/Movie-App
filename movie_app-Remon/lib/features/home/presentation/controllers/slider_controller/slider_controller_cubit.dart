import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/home/domian/entities/slider_images_model.dart';

part 'slider_controller_state.dart';

class SliderControllerCubit extends Cubit<SliderControllerState> {
  SliderControllerCubit() : super(SliderControllerInitial());

  Future<SliderImagesModel> getSliderImages() async {

    // how to trigger state
    emit(SliderControllerLoading());
    Dio dio = Dio();

    try {
      var res = await dio.get(
          'https://api.themoviedb.org/3/trending/movie/day?language=en-US',
          options: Options(headers: {
            "Authorization":
                " Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMDdmYzkwZGM3MjM0MzI3OTUzYzgyNDRmYzBmMTkzNyIsIm5iZiI6MTc1NzYxMTY3NS4zMDIsInN1YiI6IjY4YzMwNjliYTA0YzIyZmI5Nzk0OGQzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.v3surX_XHDA0fJTTBuAwtSWV04NUhbuy66VHmrEnEEM",
            "accept": "application/json",
          }));


      if(res.statusCode ==200){
        var images = SliderImagesModel.fromJson(res.data).imageUrl;
        emit(SliderControllerSuccess(images));
      }
      return SliderImagesModel.fromJson(res.data);
    } catch (e) {
      emit(SliderControllerFailure(e.toString()));
      if(e is TypeError){
        print(e.stackTrace);
      }
      print(e);
      throw e;
    }
  }
}
