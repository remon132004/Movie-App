import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/features/dashboard/presentation/ui_screens/dashboard.dart';
import 'package:movie_app/features/home/presentation/controllers/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/slider_controller/slider_controller_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_details/get_movie_details_cubit.dart';
import 'package:movie_app/main.dart';

import '../../../home/presentation/ui_screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>Dashboard(),

          // MultiBlocProvider(
          //   providers: [
          //     BlocProvider(
          //       create: (context) => SliderControllerCubit(),
          //     ),
          //     BlocProvider(
          //       create: (context) => NowPlayingCubit()..getNowPlaying(),
          //     ),
          //     BlocProvider(
          //       create: (context) => UpcomingCubit(),
          //     ),
          //     BlocProvider(create: (context) => GetMovieDetailsCubit(),)
          //   ],
          //   child: HomeScreen(),
          // )
      ));
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.steal,
      body: Center(
        child: Image.asset(
          'assets/images/popcorn 1 (2).png',
          height: 300.h,
        ),
      ),
    );
  }


}
