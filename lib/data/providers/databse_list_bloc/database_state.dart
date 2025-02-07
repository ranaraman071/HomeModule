abstract class DatabaseState {}

class InitialState extends DatabaseState {}

class DataLoadedState extends DatabaseState {
  var data;

  DataLoadedState(this.data);
}

class DataLoadingState extends DatabaseState {}

class DataErrorState extends DatabaseState {}
