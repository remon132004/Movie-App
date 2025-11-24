part of 'get_movie_details_cubit.dart';

@immutable
sealed class GetMovieDetailsState {}

final class GetMovieDetailsInitial extends GetMovieDetailsState {}
final class GetMovieDetailsLoading extends GetMovieDetailsState {}
final class GetMovieDetailsSucess extends GetMovieDetailsState {
  final MovieDetail movieDetail;

  GetMovieDetailsSucess({required this.movieDetail});
}
final class GetMovieDetailsFailed extends GetMovieDetailsState {
  final String e;

  GetMovieDetailsFailed({required this.e});
}




