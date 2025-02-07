
// state
import 'package:equatable/equatable.dart';

class AnimationState extends Equatable{

  final bool val;

  AnimationState({this.val=false});

  AnimationState copyWith({bool? val}){
    return AnimationState(val: val??this.val);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [val];
}