import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(1);

  /// Updates the selected index
  void selectTab(int index) => emit(index);
}