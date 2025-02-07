import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chips_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBlocc extends Bloc<FilterEvent, FilterState> {
  FilterBlocc() : super(FilterState(selectedCountries: [], selectedCities: [], selectedRegions: [],)){
    on<UpdateFilterEvent>(_change);
  }

  // Funtion to show selected options from filter
  void _change(UpdateFilterEvent event,Emitter<FilterState> emit){
    emit(state.copyWith(
      selectedCountries: List.from(event.selectedCountries),
      selectedCities: List.from(event.selectedCities),
      selectedRegions: List.from(event.selectedRegions)
    ));
  }
}
