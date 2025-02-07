import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/data/providers/display_data/display_event.dart';
import 'package:home_module/data/providers/display_data/display_state.dart';

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  DisplayBloc() : super(DisplayState()){

    on<DisplayedDataEvent>(_changeVal);
  }

  _changeVal(DisplayedDataEvent event ,Emitter<DisplayState> emit ){
    emit(state.copyWith(
      announcement: event.announcement,
      available: true,
      contact: event.contact,
      email: event.email,
      website: event.website,

    ));
  }

  _setSocialLogin(DisplayedDataEvent event ,Emitter<DisplayState> emit ){
    emit(state.copyWith(
      insta: true,
      tiktok: true,
      facebook: true,
      twitter: true,
    ));
  }


}