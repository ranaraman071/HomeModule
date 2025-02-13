import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SavedSliderEvent extends Equatable {
  const SavedSliderEvent();

  @override
  List<Object> get props => [];
}

class UpdateSliderEventt extends SavedSliderEvent {
  final double value;

  const UpdateSliderEventt(this.value);

  @override
  List<Object> get props => [value];
}

class StartDraggingEventt extends SavedSliderEvent {}

class StopDraggingEventt extends SavedSliderEvent {}

class UpdateScoreDataEvent extends SavedSliderEvent {
  final BuildContext context;
  final String sliderValue;
  final String bid;
  final String scoreval;

  UpdateScoreDataEvent(this.context, this.sliderValue, this.bid, this.scoreval);
}
