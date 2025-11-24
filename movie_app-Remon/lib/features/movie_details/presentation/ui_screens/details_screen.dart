import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/utils/entities/movie_model.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/movie_details/presentation/components/cast_movie_widget.dart';
import 'package:movie_app/features/movie_details/presentation/components/review_,moive_widget.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_cast/cubit/get_movie_cast_cubit.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_reviews/cubit/get_movie_reviews_cubit.dart';

import '../../../../main.dart';

import '../controllers/get_movie_details/get_movie_details_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movie});

  final dynamic movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isInWatchList = false;

  @override
  void initState() {
    super.initState();
    isInWatchList = movieBox.containsKey(widget.movie.id);
    context
        .read<GetMovieDetailsCubit>()
        .getMovieDetails(movieId: widget.movie.id);
  }

  void toggleWatchList() async {
    final movieToSave = Movie(
      id: widget.movie.id,
      title: widget.movie.title,
      posterPath: widget.movie.posterPath,
      backdropPath: widget.movie.backdropPath,
      voteAverage: widget.movie.voteAverage,
      releaseDate: widget.movie.releaseDate,
      adult: widget.movie.adult,
      genreIds: widget.movie.genreIds,
      originalLanguage: widget.movie.originalLanguage,
      originalTitle: widget.movie.originalTitle,
      overview: widget.movie.overview,
      popularity: widget.movie.popularity,
      video: widget.movie.video,
      voteCount: widget.movie.voteCount,
    );

    if (isInWatchList) {
      await movieBox.delete(movieToSave.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movieToSave.title} removed from Watchlist')),
      );
    } else {
      await movieBox.put(movieToSave.id, movieToSave);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movieToSave.title} added to Watchlist')),
      );
    }

    setState(() {
      isInWatchList = !isInWatchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff242A32),
        centerTitle: true,
        title: CustomText(
          'Detail'.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isInWatchList ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: toggleWatchList,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: 290.h,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
                    ),
                  ),
                  Positioned(
                      bottom: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200.h,
                            width: 150.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.w,
                                child: CustomText(
                                  widget.movie.title,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Positioned(
                      right: 30.w,
                      bottom: 190.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: Color(0xff242A32),
                            borderRadius: BorderRadius.circular(18)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: Color(0xffFF8700),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            CustomText(
                              widget.movie.voteAverage.toStringAsFixed(1),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffFF8700),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            BlocConsumer<GetMovieDetailsCubit, GetMovieDetailsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetMovieDetailsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetMovieDetailsSucess) {
                  var data = state.movieDetail;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff92929D),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            widget.movie.releaseDate.toString().split('-')[0],
                            color: Color(0xff92929D),
                          ),
                          SizedBox(
                            height: 22.h,
                            child: VerticalDivider(),
                          ),
                          Icon(
                            Icons.access_time,
                            color: Color(0xff92929D),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            '${data.runtime} ' 'minutes'.tr(),
                            color: Color(0xff92929D),
                          ),
                          SizedBox(
                            height: 22.h,
                            child: VerticalDivider(),
                          ),
                          Icon(
                            Icons.confirmation_num_outlined,
                            color: Color(0xff92929D),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomText(
                            data.genres.first.name,
                            color: Color(0xff92929D),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              dividerHeight: 0,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Color(0xff3A3F47),
                              labelColor: Color(0xffFFFFFF),
                              unselectedLabelColor: Color(0xffFFFFFF),
                              tabs: [
                                Tab(
                                  text: "About Movie".tr(),
                                ),
                                Tab(
                                  text: "Reviews".tr(),
                                ),
                                Tab(
                                  text: "Cast".tr(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 400.h,
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: CustomText(
                                      data.overview,
                                      fontSize: 15,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                  BlocProvider(
                                    create: (context) => GetMovieReviewsCubit()
                                      ..getMovieReviews(
                                          movieId: widget.movie.id),
                                    child: ReviewsMovie(),


                                  ),
                                  BlocProvider(
                                    create: (context) => GetMovieCastCubit()
                                      ..getMovieCast(movieId: widget.movie.id),
                                    child: CastMovie(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (state is GetMovieDetailsFailed) {
                  return Center(
                    child: CustomText(state.e),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
