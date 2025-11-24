part of 'slider_controller_cubit.dart';

@immutable
sealed class SliderControllerState {}

final class SliderControllerInitial extends SliderControllerState {}

final class SliderControllerLoading extends SliderControllerState {}

final class SliderControllerSuccess extends SliderControllerState {
  final List<String> images;

  SliderControllerSuccess(this.images);
}

final class SliderControllerFailure extends SliderControllerState {
  final String message;

  SliderControllerFailure(this.message);
}
