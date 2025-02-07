import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterBloc extends Bloc<FilterArrowEvent,FilterArrowState>{
  FilterBloc() : super(FilterArrowState()){
    on<FilterArrowChangeEvent>(changeVal);
  }

  // Filter Sort button change state
  void changeVal(FilterArrowChangeEvent event,Emitter<FilterArrowState> emit){
    if(state.val=="up"){emit(FilterArrowState(val: "down"));}
    else if(state.val=="down"){emit(FilterArrowState(val: "updown"));}
    else if(state.val=="updown"){emit(FilterArrowState(val: "up"));}
  }
}