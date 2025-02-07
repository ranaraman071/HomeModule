import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {}

class UpdateFilterEvent extends FilterEvent {
  final List selectedCountries;
  final List selectedCities;
  final List selectedRegions;

  UpdateFilterEvent(
      this.selectedCountries, this.selectedCities, this.selectedRegions);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [selectedCountries, selectedCities, selectedRegions];
}
