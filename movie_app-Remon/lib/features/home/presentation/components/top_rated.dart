import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/home/presentation/controllers/top_rated_cubit/top_rated_cubit.dart';
import 'package:movie_app/features/home/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  @override
  void initState() {
    context.read<TopRatedCubit>().getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedCubit, TopRatedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is UpcomingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TopRatedSuccess) {
          var data  = state.topRatedModel.results;
          return GridView.builder(
            itemCount: data.length,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 17.w,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${data[index].posterPath}',
                fit: BoxFit.fill,
              ),
            ),
          );
        }
        if (state is TopRatedFailure) {
          return Center(
            child: CustomText(state.message),
          );
        }
        print(state);
        return Container();
      },
    );
  }
}
