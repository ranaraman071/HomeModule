import 'package:equatable/equatable.dart';

abstract class SavedSliderState extends Equatable {
  const SavedSliderState();

  @override
  List<Object> get props => [];
}

class SliderUpdatedState extends SavedSliderState {
  final double value;
  final String label;
  final bool isDragging;

  const SliderUpdatedState(this.value, this.label, this.isDragging);

  @override
  List<Object> get props => [value, label, isDragging];
}
