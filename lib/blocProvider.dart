import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_pic_selector/bloc/bloc.dart';

class BlocProviders {
  // This function returns a list of BlocProvider widgets
  static List<BlocProvider> getAllProviders() {
    return [
      BlocProvider<ProfileImageBloc>(create: (context) => ProfileImageBloc()),
    ];
  }
}