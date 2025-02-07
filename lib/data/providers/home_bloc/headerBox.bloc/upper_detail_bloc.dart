import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/headerBox_event.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/headerBox_state.dart';


// BLoC Implementation
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(AppBarState()){

    on<AppBarCollapsed>(_changeVal);
  }

  _changeVal(AppBarCollapsed event ,Emitter<AppBarState> emit ){
    emit(state.copyWith(val: event.val));
  }
}
