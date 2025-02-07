abstract class FilterEvent {}

class FetchFilterDataEvent extends FilterEvent {}

class FetchDataWithRegionEvent extends FilterEvent {
  String region = "";
  List name = [];

  FetchDataWithRegionEvent({required this.region, required this.name});
}

class SetCoutryEvent extends FilterEvent {
  final country;

  SetCoutryEvent(this.country);
}
