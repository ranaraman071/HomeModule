import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/language_cubit/language_cubit.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/slider_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_bloc.dart';


class BlocProviders {
  static List<BlocProvider> getAllProviders() {
    return [
      BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
      BlocProvider<SliderBloc>(create: (_) => SliderBloc()),
      BlocProvider<ValueBloc>(create: (_) => ValueBloc()),
      BlocProvider<SavedSliderBloc>(create: (_) => SavedSliderBloc()),
    ];
  }
}