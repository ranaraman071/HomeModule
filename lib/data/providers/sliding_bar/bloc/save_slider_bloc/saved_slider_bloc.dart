import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/save_slider_state.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_event.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_event.dart';
import 'package:score_bar_project/presentation/themes/snackbar.dart';
import 'package:score_bar_project/utils/database_services.dart';
import 'package:score_bar_project/utils/navigator_services.dart';

class SavedSliderBloc extends Bloc<SavedSliderEvent, SavedSliderState> {
  SavedSliderBloc() : super(const SliderUpdatedState(0.8, "Lacking", false)) {
    on<UpdateSliderEventt>((event, emit) {
      final label = _getLabelForValue(event.value);
      emit(SliderUpdatedState(event.value, label, true));
    });

    on<StartDraggingEventt>((event, emit) {
      if (state is SliderUpdatedState) {
        final currentState = state as SliderUpdatedState;
        emit(SliderUpdatedState(currentState.value, currentState.label, true));
      }
    });

    on<StopDraggingEventt>((event, emit) {
      if (state is SliderUpdatedState) {
        final currentState = state as SliderUpdatedState;
        emit(SliderUpdatedState(currentState.value, currentState.label, false));
      }
    });

    on<UpdateScoreDataEvent>((event, emit) async {
      updateData(event.context, event.sliderValue, event.bid, event.scoreval);
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

  updateData(BuildContext context, String sliderValue, String bid, String scoreval) async {
    await DatabaseHelper.updateData('R', {'Score': sliderValue}, 'BID = $bid', []);
    showCustomSnackBar(context, "Data Saved", color: Colors.green);
    //UPDATE R SET score = 0.8 WHERE bid=2;
    context.read<ValueBloc>().add(ChangeValEvent(double.parse(scoreval)));
    NavigatorService().pop();
  }
}
