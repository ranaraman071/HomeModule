import 'package:equatable/equatable.dart';

abstract class ValueEvent extends Equatable {}

class ChangeValEvent extends ValueEvent {
  final double value;

  ChangeValEvent(this.value);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
