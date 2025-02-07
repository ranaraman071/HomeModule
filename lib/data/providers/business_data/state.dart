// state
import 'package:equatable/equatable.dart';

class DataFetchState extends Equatable {
  final String buisinessName;
  final String opentiming;
  final String opened;

  DataFetchState(
      {this.buisinessName = "Central Computer",
      this.opentiming = "7AM-10PM",
      this.opened = "Closed"});

  DataFetchState copyWith({String? buisinessName,String? opentiming,String? opened}) {
    return DataFetchState(
      buisinessName: buisinessName ?? this.buisinessName,
      opentiming: opentiming ?? this.opentiming,
      opened: opened ?? this.opened,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [buisinessName,opentiming,opened];
}
