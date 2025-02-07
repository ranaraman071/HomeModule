import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit extends Cubit<bool> {
  DropdownCubit() : super(false);

  // Funtion to display and hide the filter box
  void changeVal(bool val) => emit(val);
}
