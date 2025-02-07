import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/data/providers/animation_cubit/animation_event.dart';
import 'package:home_module/data/providers/animation_cubit/animation_state.dart';


// BLoC Implementation
class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  AnimationBloc() : super(AnimationState()){

    on<AnimateEvent>(_changeVal);
  }

  _changeVal(AnimateEvent event ,Emitter<AnimationState> emit ) async {
    emit(state.copyWith(val: event.val));
    await Future.delayed(Duration(seconds: 5));
    emit(state.copyWith(val: false));
  }
}
