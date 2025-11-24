part of 'get_filtered_movie_cubit.dart';

@immutable
sealed class GetFilteredMovieState {}

final class GetFilteredMovieInitial extends GetFilteredMovieState {}
final class GetFilteredMovieLoading extends GetFilteredMovieState {}
final class GetFilteredMovieSuccess extends GetFilteredMovieState {
  final SearchMovieResponseEntity  result;

  GetFilteredMovieSuccess(this.result);
}
final class GetFilteredMovieFailure extends GetFilteredMovieState {
  final String message;

  GetFilteredMovieFailure(this.message);
}
