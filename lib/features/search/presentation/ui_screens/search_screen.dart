import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:movie_app/features/search/presentation/controllers/get_filterd_movie/get_filtered_movie_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      color: AppColors.steal,
      child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              CustomText(
                'search_tab'.tr(),
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Icon(

                Icons.error_outline,
                size: 17.h,
                color: AppColors.white,
              )
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          CustomTextFormField(
            controller: searchController,
            hintText: 'search_tap',
            textColor: AppColors.white,
            suffixIcon: Icon(

              Icons.search,
              size: 17.h,
              color: AppColors.grey2,
            ),
            onChanged: (p0) {
              context.read<GetFilteredMovieCubit>().getFilterdMovie(p0);
            },
          ),
          BlocBuilder<GetFilteredMovieCubit, GetFilteredMovieState>(
            builder: (context, state) {
              if (state is GetFilteredMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetFilteredMovieSuccess) {
                var movies = state.result.results;
                return Expanded(
                  child: Container(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: movies.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          SizedBox(
                            height: 160.h,
                            width: 140.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${movies[index].posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 190.w,
                                child: CustomText(

                                  movies[index].title,

                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  Icon(

                                    Icons.star_border,
                                    size: 17.h,
                                    color: AppColors.orange,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomText(
                                    movies[index].voteAverage.toString(),
                                    color: AppColors.orange,
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                children: [
                                  Icon(

                                    Icons.confirmation_num_outlined,
                                    size: 17.h,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomText(
                                      movies[index].genreIds.isEmpty?'100':
                                    movies[index].genreIds.first.toString(),
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                children: [
                                  Icon(

                                    Icons.calendar_today_outlined,
                                    size: 17.h,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomText(
                                    movies[index].releaseDate.toString(),
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                children: [
                                  Icon(

                                    Icons.timelapse,
                                    size: 17.h,
                                    color: AppColors.white,

                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomText(
                                    movies[index].voteCount.toString(),
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (state is GetFilteredMovieFailure) {
                return Center(
                  child: CustomText(
                    'There is an Error:${state.message}',
                    maxLine: 4,
                    fontSize: 24.w,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                    ),
                    SvgPicture.asset('assets/images/no-results 1.svg'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          'not_found_title'.tr(),
                          maxLine: 2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      'not_found_message'.tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.grey2,
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
