part of 'top_rated_cubit.dart';

@immutable
sealed class TopRatedState {}

final class TopRatedInitial extends TopRatedState {}

final class TopRatedLoading extends TopRatedState {}
final class TopRatedFailure extends TopRatedState {
  final String message;

  TopRatedFailure(this.message);
}
final class TopRatedSuccess extends TopRatedState {
  final TopRatedModel topRatedModel;

  TopRatedSuccess(this.topRatedModel);
}
