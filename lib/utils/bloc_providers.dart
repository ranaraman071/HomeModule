
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/data/providers/animation_cubit/animation_bloc.dart';
import 'package:home_module/data/providers/business_data/bloc.dart';
import 'package:home_module/data/providers/display_data/display_bloc.dart';
import 'package:home_module/data/providers/home_bloc/tabBar_bloc.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/upper_detail_bloc.dart';
import 'package:home_module/data/providers/language_cubit/language_cubit.dart';

class BlocProviders {
  // This function returns a list of BlocProvider widgets
  static List<BlocProvider> getAllProviders() {
    return [
      BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
      BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
      BlocProvider<AppBarBloc>(create: (_) => AppBarBloc()),
      BlocProvider<AnimationBloc>(create: (_) => AnimationBloc()),
      BlocProvider<DisplayBloc>(create: (_) => DisplayBloc()),
      BlocProvider<DataDisplayBloc>(create: (_) => DataDisplayBloc()),
    ];
  }
}