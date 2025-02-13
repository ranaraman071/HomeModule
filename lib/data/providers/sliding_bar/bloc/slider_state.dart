import 'package:equatable/equatable.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

class SliderUpdatedState extends SliderState {
  final double value;
  final String label;
  final bool isDragging;

  const SliderUpdatedState(this.value, this.label, this.isDragging);

  @override
  List<Object> get props => [value, label, isDragging];
}
