import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/utils/widgets/custom_text.dart';
import 'package:movie_app/features/movie_details/presentation/controllers/get_movie_reviews/cubit/get_movie_reviews_cubit.dart';


class ReviewsMovie extends StatelessWidget {
  const ReviewsMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: BlocBuilder<GetMovieReviewsCubit, GetMovieReviewsState>(
        builder: (context, state) {
          if (state is GetMovieReviewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMovieReviewsSuccess) {
            final reviews = state.movieReviewsModel.results;

            if (reviews.isEmpty) {
              return const Center(
                child: CustomText(
                  "No reviews available",
                  color: Colors.white,
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final review = reviews[index];
                final author = review.authorDetails;

                
                final avatarUrl = author.avatarPath != null
                    ? 'https://image.tmdb.org/t/p/w200${author.avatarPath}'
                    : 'https://via.placeholder.com/80x80';
                final displayName = author.name.isNotEmpty
                    ? author.name
                    : author.username.isNotEmpty
                    ? author.username
                    : "Unknown";
                final ratingText = author.rating != null ? author.rating.toString() : "-";
                final contentText = review.content.isNotEmpty ? review.content : "No review available";

                return Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: author.avatarPath != null
                                    ? Image.network(
                                  'https://image.tmdb.org/t/p/w200${author.avatarPath}',
                                  height: 60.h,
                                  width: 60.w,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRAyBI63eQoPCKt-PLWxOUsn9Bkp2PhBM8Uw&s',
                                  height: 60.h,
                                  width: 60.w,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(height: 4.h),
                              CustomText(
                                ratingText,
                                color: Colors.blue,
                                fontSize: 12,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  displayName,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 4.h),
                                ExpandableText(text: contentText),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GetMovieReviewsFailure) {
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

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({super.key, required this.text, this.trimLines = 3});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;

    return LayoutBuilder(builder: (context, constraints) {
      final span = TextSpan(text: text);
      final tp = TextPainter(
        text: span,
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: constraints.maxWidth);

      final exceeded = tp.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
            maxLines: isExpanded ? null : widget.trimLines,
            overflow: TextOverflow.fade,
          ),
          if (exceeded)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  isExpanded ? "Show less" : "Read more",
                  style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
                ),
              ),
            )
        ],
      );
    });
  }
}