import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/dropdown/filter_box_close_cubit.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chips_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:database_task/data/providers/language_cubit/language_cubit.dart';

class BlocProviders {
  static List<BlocProvider> getAllProviders() {
    return [
      BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
      BlocProvider<DatabaseBloc>(create: (_) => DatabaseBloc()),
      BlocProvider<FilterBloc>(create: (_) => FilterBloc()),
      BlocProvider<DropdownCubit>(create: (_) => DropdownCubit()),
      BlocProvider<FilterDataBloc>(create: (_) => FilterDataBloc()),
      BlocProvider<FilterBlocc>(create: (_) => FilterBlocc()),
    ];
  }
}