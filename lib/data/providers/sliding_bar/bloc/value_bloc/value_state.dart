import 'package:equatable/equatable.dart';

class ValueState extends Equatable {
  final double value;
  List<Map<String, dynamic>> data;

  ValueState({this.value = 0.8, required this.data});

  ValueState copyWith({double? value, List<Map<String, dynamic>>? data}) {
    return ValueState(value: value ?? this.value, data: data ?? []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [value, data];
}
