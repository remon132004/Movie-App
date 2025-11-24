part of 'get_movie_reviews_cubit.dart';

@immutable
sealed class GetMovieReviewsState {}

final class GetMovieReviewsInitial extends GetMovieReviewsState {}

final class GetMovieReviewsLoading extends GetMovieReviewsState {}

final class GetMovieReviewsSuccess extends GetMovieReviewsState {
  final MovieReviewsModel movieReviewsModel;

  GetMovieReviewsSuccess({required this.movieReviewsModel});
}

final class GetMovieReviewsFailure extends GetMovieReviewsState {
  final String e;

  GetMovieReviewsFailure({required this.e});
}
