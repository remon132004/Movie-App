import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/home/presentation/controllers/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_details/get_movie_details_cubit.dart';
import 'package:movie_app/features/movie_details/presentation/ui_screens/details_screen.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NowPlayingCubit, NowPlayingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is NowPlayingSuccess) {
          var data = state.movies.results;
          return GridView.builder(
            itemCount: state.movies.results.length,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 17.w,
                childAspectRatio: 0.9,
                crossAxisCount: 3),
            itemBuilder: (context, index) =>
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) => GetMovieDetailsCubit(),
                                child: DetailsScreen(
                                  movie: data[index],
                                ),
                              ),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${data[index]
                          .posterPath}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          );
        }
        if (state is NowPlayingFailure) {
          return Center(
            child: CustomText(
              state.message,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          );
        }
        return Container();
      },
    );
  }
}
