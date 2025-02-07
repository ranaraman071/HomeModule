import 'package:equatable/equatable.dart';

abstract class FilterArrowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterArrowChangeEvent extends FilterArrowEvent {}
