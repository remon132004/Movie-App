import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/core/utils/entities/movie_model.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_details/get_movie_details_cubit.dart';


class AboutMovieWidget extends StatelessWidget {
  const AboutMovieWidget({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Column(
        children: [
          SizedBox(height: 30.h,),
          CustomText(movie.overview,color: AppColors.white,maxLine: 7,),
        ],
      ),
    );
  }
}

