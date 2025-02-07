// Events
import 'package:equatable/equatable.dart';

abstract class AnimationEvent extends Equatable {
  @override
  List<Object?> get props=>[];
}
class AnimateEvent extends AnimationEvent {
  final bool val;
  AnimateEvent({required this.val});

  @override
  List<Object?> get props=>[val];
}