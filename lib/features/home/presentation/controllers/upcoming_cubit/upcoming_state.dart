part of 'upcoming_cubit.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingLoading extends UpcomingState {}
final class UpcomingSuccess extends UpcomingState {
  final UpcomingModel upcomingModel;

  UpcomingSuccess(this.upcomingModel);
}
final class UpcomingFailure extends UpcomingState {
  final String message;

  UpcomingFailure(this.message);
}
