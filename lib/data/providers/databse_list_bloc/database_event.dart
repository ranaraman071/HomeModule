import 'package:flutter/material.dart';

abstract class DatabaseEvent {}

class FetchFromDatabaseEvent extends DatabaseEvent {}

class SortingDataEvent extends DatabaseEvent {
  final String val;

  SortingDataEvent(this.val);
}

class GetDataWithFilterEvent extends DatabaseEvent {
  var dataa;

  GetDataWithFilterEvent(this.dataa);
}

class SearchQueryChanged extends DatabaseEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class FilteratabaseEvent extends DatabaseEvent {
  BuildContext context;
  List<dynamic>? cities;
  List<dynamic>? countries;
  List<dynamic>? regions;

  FilteratabaseEvent(this.context, this.countries, this.cities, this.regions);
}
