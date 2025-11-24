import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/home/presentation/controllers/upcoming_cubit/upcoming_cubit.dart';

class UpComing extends StatefulWidget {
  const UpComing({super.key});

  @override
  State<UpComing> createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {
  @override
  void initState() {
    context.read<UpcomingCubit>().getUpComing();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpcomingCubit, UpcomingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if(state is UpcomingLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if( state is UpcomingSuccess){
          var data  = state.upcomingModel.results;
          return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemCount: 24,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 17.w,
                childAspectRatio: .9,
              ),
              itemBuilder: (context, index) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${data[index].posterPath}',
                      fit: BoxFit.fill,
                    ),
                  ));
        }
        if(state is UpcomingFailure) {
          return Center(child: CustomText('there si an error '),);
        }
        return Container();
      },
    );
  }
}