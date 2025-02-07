// BLoC Implementation
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/data/providers/business_data/event.dart';
import 'package:home_module/data/providers/business_data/state.dart';

class DataDisplayBloc extends Bloc<DataEvent, DataFetchState> {
  DataDisplayBloc() : super(DataFetchState()){

    on<DataDisplayEvent>(fetchData);
  }

  fetchData(DataEvent event ,Emitter<DataFetchState> emit ) async {
    emit(state.copyWith(
      buisinessName: state.buisinessName,
      opentiming: state.opentiming,
      opened: state.opened,
    ));
  }
}