import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List selectedCountries;
  final List selectedCities;
  final List selectedRegions;

  FilterState({
    required this.selectedCountries,
    required this.selectedCities,
    required this.selectedRegions,
  });

  // CopyWith method allows creating a new FilterState with updated values.
  FilterState copyWith({
    List? selectedCountries,
    List? selectedCities,
    List? selectedRegions,
  }) {
    return FilterState(
      selectedCountries: selectedCountries ?? List.from(this.selectedCountries),
      selectedCities: selectedCities ?? this.selectedCities,
      selectedRegions: selectedRegions ?? this.selectedRegions,
    );
  }

  @override
  // Equatable ensures proper comparison for equality and prevents unnecessary rebuilds in Flutter.
  List<Object?> get props =>
      [selectedCountries, selectedCities, selectedRegions];
}
