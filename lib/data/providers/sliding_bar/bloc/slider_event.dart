import 'package:equatable/equatable.dart';

abstract class SliderEvent extends Equatable {
  const SliderEvent();

  @override
  List<Object> get props => [];
}

class UpdateSliderEvent extends SliderEvent {
  final double value;

  const UpdateSliderEvent(this.value);

  @override
  List<Object> get props => [value];
}

class StartDraggingEvent extends SliderEvent {}

class StopDraggingEvent extends SliderEvent {}
