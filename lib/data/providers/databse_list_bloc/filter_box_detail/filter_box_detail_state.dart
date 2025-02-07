import 'package:equatable/equatable.dart';

class FilterDataLoadeddState extends Equatable {
  final List<String> countriesData;
  final List<String> selectcountriesData;
  final List<String> citiesData;
  final List<String> citiesCopiesData;
  final List<String> regions;
  List<Map<String, dynamic>> cityFilterMap = [];
  List<Map<String, dynamic>> countryFilterMap = [];
  List<Map<String, dynamic>> regionFilterMap = [];

  FilterDataLoadeddState(
      {required this.countriesData,
      required this.selectcountriesData,
      required this.citiesData,
        required this.citiesCopiesData,
      required this.regions,
      required this.cityFilterMap,
      required this.countryFilterMap,
      required this.regionFilterMap});

  FilterDataLoadeddState copyWith(
      {List<String>? countriesData,
      List<String>? citiesData,
      List<String>? citiesCopiesData,
      List<String>? regions,
      List<String>? selectcountriesData,
      List<Map<String, dynamic>>? cityFilterMap,
      List<Map<String, dynamic>>? countryFilterMap,
      List<Map<String, dynamic>>? regionFilterMap}) {
    return FilterDataLoadeddState(
        countriesData: countriesData ?? [],
        citiesData: citiesData ?? [],
        citiesCopiesData: citiesCopiesData ?? [],
        regions: regions ?? [],
        selectcountriesData: selectcountriesData ?? [],
        cityFilterMap: cityFilterMap ?? [],
        countryFilterMap: countryFilterMap ?? [],
        regionFilterMap: regionFilterMap ?? []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        countriesData,
        citiesData,
    citiesCopiesData,
        regions,
        selectcountriesData,
        cityFilterMap,
        countryFilterMap,
        regionFilterMap
      ];
}

class SelectedDataLoadeddState extends Equatable {
  final List<String> countriesData;
  final List<String> citiesData;
  final List<String> regions;

  SelectedDataLoadeddState(
      {required this.countriesData,
      required this.citiesData,
      required this.regions});

  SelectedDataLoadeddState copyWith({
    List<String>? countriesData,
    List<String>? citiesData,
    List<String>? regions,
  }) {
    return SelectedDataLoadeddState(
        countriesData: countriesData ?? [],
        citiesData: citiesData ?? [],
        regions: regions ?? []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [countriesData, citiesData, regions];
}
