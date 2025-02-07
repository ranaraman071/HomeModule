import 'package:equatable/equatable.dart';

class FilterArrowState extends Equatable {
  final String val;

  FilterArrowState({this.val = "updown"});

  FilterArrowState copyWith({String? val}) {
    return FilterArrowState(val: val ?? this.val);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [val];
}
