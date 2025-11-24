import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/features/favourite/ui_screen/favourite_screen.dart';
import 'package:movie_app/features/home/presentation/controllers/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/slider_controller/slider_controller_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';
import 'package:movie_app/features/home/presentation/ui_screens/home_screen.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_details/get_movie_details_cubit.dart';
import 'package:movie_app/features/search/presentation/controllers/get_filterd_movie/get_filtered_movie_cubit.dart';
import 'package:movie_app/features/search/presentation/ui_screens/search_screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SliderControllerCubit(),
        ),
        BlocProvider(
          create: (context) =>
          NowPlayingCubit()
            ..getNowPlaying(),
        ),
        BlocProvider(
          create: (context) => UpcomingCubit(),
        ),
        BlocProvider(
          create: (context) => GetMovieDetailsCubit(),
        )
      ],
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => GetFilteredMovieCubit(),
      child: SearchScreen(),
    ),
    FavouriteScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
          print(value);
        },
        iconSize: 40.h,
        currentIndex: index,
        unselectedItemColor: AppColors.grey2,
        selectedItemColor: AppColors.whiteBlue,
        backgroundColor: AppColors.steal,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
        ],
      ),
    );
  }
}
