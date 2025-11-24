part of 'get_movie_cast_cubit.dart';

@immutable
sealed class GetMovieCastState {}

final class GetMovieCastInitial extends GetMovieCastState {}
final class GetMovieCastLoading extends GetMovieCastState {}
final class GetMovieCastSuccess extends GetMovieCastState {
  final MovieCastModel movieCastModel;

  GetMovieCastSuccess({required this.movieCastModel});

}
final class GetMovieCastFailure extends GetMovieCastState {
  final String e;

  GetMovieCastFailure({required this.e});

}