// Events
import 'package:equatable/equatable.dart';

abstract class AppBarEvent extends Equatable {
  @override
  List<Object?> get props=>[];
}
class AppBarCollapsed extends AppBarEvent {
  final bool val;
  AppBarCollapsed({required this.val});

  @override
  List<Object?> get props=>[val];
}