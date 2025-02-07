import 'package:database_task/data/providers/databse_list_bloc/database_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_state.dart';
import 'package:database_task/utils/database_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> allData = [];

  DatabaseBloc() : super(InitialState()) {

    on<FetchFromDatabaseEvent>((event, emit) async {fetchData();});

    on<SortingDataEvent>((event, emit) async {
      if (event.val == "updown") {
        sortItemsAcending(allData);
        emit(DataLoadedState(allData));
      } else if (event.val == "up") {
        sortItemsDesending(allData);
        emit(DataLoadedState(allData));
      } else if (event.val == "down") {
        fetchData();
      }
    });

    on<GetDataWithFilterEvent>((event, emit) async {
      allData = event.dataa;
      emit(DataLoadedState(event.dataa));
    });

    on<SearchQueryChanged>((event, emit) async {searchData(event.query);});

    on<FilteratabaseEvent>((event, emit) async {
      getFilteredBusinesses(event.context, countries: event.countries, cities: event.cities, regions: event.regions);});
  }

  // Fetch from database file
  fetchData() async {
    data.clear();
    List<Map<String, dynamic>> dataa = await DatabaseHelperr.fetchData('td');
    for (var i in dataa) {data.add(i);}
    emit(DataLoadedState(data));
    allData = data;
  }

  // Ascending Sorting
  void sortItemsAcending(var data) {
    data.sort((a, b) {
      DateTime dateA = DateTime.parse(a["time"]);
      DateTime dateB = DateTime.parse(b["time"]);
      return dateB.compareTo(dateA); // Most recent first
    });
  }

  // Descending sorting
  void sortItemsDesending(var data) {
    data.sort((a, b) {
      DateTime dateA = DateTime.parse(a["time"]);
      DateTime dateB = DateTime.parse(b["time"]);
      return dateA.compareTo(dateB); // Most recent first
    });
  }

  // Search Text funtion
  searchData(String query) {
    List<Map<String, dynamic>> filteredData = [];
    if (query.isNotEmpty) {
      filteredData = allData.where((item) => item['name'].toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredData = allData;
    }
    emit(DataLoadedState(filteredData));
  }

  // Show result according to selected filter
  void getFilteredBusinesses(context, {List<dynamic>? cities, List<dynamic>? countries, List<dynamic>? regions}) async {
    String cityFilterCountry = "";
    String cityFilter = "";
    String countryFilter = "";
    String regionFilter = "";
    String combinedFilter = "";
    String query = "SELECT * FROM td WHERE 1=1";

    if (cities != null && cities.isNotEmpty) {
      cityFilter = cities.map((c) => "'${c.split(',')[0]}'").join(",");
      cityFilterCountry = cities.where((c) => c.contains(',')).map((c) => "'${c.split(',').last.trim()}'").join(",");
    }

    if (countries != null && countries.isNotEmpty) {countryFilter = countries.map((c) => "'$c'").join(",");}

    if (regions != null && regions.isNotEmpty) {regionFilter = regions.map((r) => "'$r'").join(",");}

    if ((countries != null && countries.isNotEmpty) || cityFilterCountry.isNotEmpty) {
      combinedFilter = [countryFilter, cityFilterCountry].where((filter) => filter.isNotEmpty).join(",").trim();
    }

    if (countryFilter.isNotEmpty || cityFilter.isNotEmpty || cityFilterCountry.isNotEmpty || regionFilter.isNotEmpty) {
      if (combinedFilter.isNotEmpty) {query += " AND country IN ($combinedFilter)";}
      if (cityFilter.isNotEmpty) {query += " AND city IN ($cityFilter)";}
      if (regionFilter.isNotEmpty) {query += " AND region IN ($regionFilter)";}
    } else {query = "SELECT * FROM td";}

    List<Map<String, dynamic>> result = await DatabaseHelper.fetchDataWithQuery(query);
    allData = result;
    emit(DataLoadedState(result));
  }
}
