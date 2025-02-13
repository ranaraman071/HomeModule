import 'package:flutter_bloc/flutter_bloc.dart';
import 'slider_event.dart';
import 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(const SliderUpdatedState(0.8, "Lacking", false)) {
    on<UpdateSliderEvent>((event, emit) {
      final label = _getLabelForValue(event.value);
      emit(SliderUpdatedState(event.value, label, true));
    });

    on<StartDraggingEvent>((event, emit) {
      if (state is SliderUpdatedState) {
        final currentState = state as SliderUpdatedState;
        emit(SliderUpdatedState(currentState.value, currentState.label, true));
      }
    });

    on<StopDraggingEvent>((event, emit) {
      if (state is SliderUpdatedState) {
        final currentState = state as SliderUpdatedState;
        emit(SliderUpdatedState(currentState.value, currentState.label, false));
      }
    });
  }

  String _getLabelForValue(double value) {
    if (value < 1.1) return "Lacking";
    if (value < 1.5) return "Standard";
    if (value < 2.5) return "Fair";
    if (value < 3.5) return "Good";
    if (value < 4.2) return "Great";
    if (value < 4.8) return "AMAZING";
    if (value < 5.1) return "PERFECT";
    return "Great";
  }
}
