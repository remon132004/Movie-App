import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:movie_app/features/home/presentation/components/now_playing.dart';
import 'package:movie_app/features/home/presentation/components/popular.dart';
import 'package:movie_app/features/home/presentation/components/top_rated.dart';
import 'package:movie_app/features/home/presentation/components/upcoming.dart';
import 'package:movie_app/features/home/presentation/controllers/popular_controller/cubit/popular_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/slider_controller/slider_controller_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // call cubit fun
    print('getSliderImages calling');
    context.read<SliderControllerCubit>().getSliderImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.steal,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<SliderControllerCubit, SliderControllerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SliderControllerLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SliderControllerSuccess) {
                var images = state.images;
                return DefaultTabController(
                  length: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'what_to_watch'.tr(),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey2,
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          hintText: 'search_tab'.tr(),
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.grey2,
                          ),
                          onTap: () {
                            print('search tapped');
                          },
                          readOnly: true,
                        ),
                        SizedBox(height: 24.h),
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            aspectRatio: 0.9,
                            autoPlay: true,
                            autoPlayCurve: Curves.linear,
                          ),
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${images[itemIndex]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        TabBar(
                          dividerHeight: 0,
                          unselectedLabelColor: AppColors.white,
                          labelColor: AppColors.white,
                          indicatorColor: AppColors.white,
                          tabs: [
                            Tab(text: 'now_playing'.tr()),
                            Tab(text: 'upcoming'.tr()),
                            Tab(text: 'top_rated'.tr()),
                            Tab(text: 'popular'.tr()),
                          ],
                        ),
                        Container(
                          height: 350.h,
                          child: TabBarView(
                            children: [
                              NowPlaying(),
                              UpComing(),
                              BlocProvider(
                                create: (context) =>
                                    TopRatedCubit()..getTopRated(),
                                child: TopRated(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    PopularCubit()..getPopular(),
                                child: Popular(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is SliderControllerFailure) {
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
          ),
        ),
      ),
    );
  }
}
