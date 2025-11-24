import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/utils/entities/movie_model.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/main.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<Movie> movies;

  @override
  void initState() {
    movies = movieBox.values.toList();
    print('movies count:${movies.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.steal,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120.h,
          ),
          movies.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                        width: 75,
                        height: 75,
                        child: SvgPicture.asset(
                          'assets/images/magic-box 1.svg',
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'There is no movie yet!',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Find your movie by Type title, categories, years, etc  ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Expanded(
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
                              SizedBox(
                                height: 5.h,
                              ),
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
                                    movies[index].genreIds.isEmpty
                                        ? '100'
                                        : movies[index]
                                            .genreIds
                                            .first
                                            .toString(),
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
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
                              SizedBox(
                                height: 5.h,
                              ),
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
                          ),
                          GestureDetector(
                            onTap: () {
                              movieBox.delete(movies[index].id);
                              setState(() {

                                movies = movieBox.values.toList();
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 14.w,
                              child:Icon(Icons.remove,color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
