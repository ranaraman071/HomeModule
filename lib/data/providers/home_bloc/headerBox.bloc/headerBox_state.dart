
// state
import 'package:equatable/equatable.dart';

class AppBarState extends Equatable{

  final bool val;

  AppBarState({this.val=false});

  AppBarState copyWith({bool? val}){
    return AppBarState(val: val??this.val);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [val];
}