import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_cast/cubit/get_movie_cast_cubit.dart';


class CastMovie extends StatelessWidget {
  const CastMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: BlocBuilder<GetMovieCastCubit, GetMovieCastState>(
        builder: (context, state) {
          if (state is GetMovieCastLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMovieCastSuccess) {
            final castList = state.movieCastModel.cast;

            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: castList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final actor = castList[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        actor.profilePath != null
                            ? 'https://image.tmdb.org/t/p/w200${actor.profilePath}'
                            : 'https://via.placeholder.com/100x100',
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhXNbDQBWKDiaqzjwXbaVo74Rcz73r3k2gL1E15yDznXhjzDIB7iCp7hp8N7djK_tkRlembvWmdSq4pcCFxejNhwIm4oxsujw5i2_cdJXW_jISiaXBNjLJ_9-QSoaMgnKisKVNUWYDW2AQ/s1600/00.jpg',
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      actor.name,
                      color: Colors.white,
                      fontSize: 12,
                      textAlign: TextAlign.center,
                      maxLine: 1,
                    ),
                    CustomText(
                      actor.character,
                      color: Colors.grey,
                      fontSize: 11,
                      textAlign: TextAlign.center,
                      maxLine: 1,
                    ),
                  ],
                );
              },
            );
          } else if (state is GetMovieCastFailure) {
            return Center(
              child: CustomText(
                "Error: ${state.e}",
                color: Colors.red,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}