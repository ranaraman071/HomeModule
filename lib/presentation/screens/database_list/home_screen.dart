import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/dropdown/filter_box_close_cubit.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chips_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chips_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/chips_bloc/chip_state.dart';
import 'package:database_task/presentation/screens/database_list/home_screen_filter_box.dart';
import 'package:database_task/presentation/themes/color_constants.dart';
import 'package:database_task/presentation/widgets/common_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:database_task/presentation/screens/database_list/home_screen_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey buttonKey = GlobalKey();
  OverlayEntry? overlayEntry;
  bool isDropdownOpen = false;
  List selectedcountries = [];
  List selectedcities = [];
  List selectedregions = [];

  // trigger filter box function
      void toggleDropdown() {
      if (context.read<DropdownCubit>().state) {
        overlayEntry?.remove();
        overlayEntry = null;
      } else {
        overlayEntry = createOverlayEntry();
        Overlay.of(context).insert(overlayEntry!);
      }
      isDropdownOpen = !isDropdownOpen;
      context.read<DropdownCubit>().changeVal(isDropdownOpen);
    }

  // Filter box connection with Home screen
  OverlayEntry createOverlayEntry() {
    RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(builder: (context) => Stack(
      children: [
        GestureDetector(
          onTap: () async {
            context.read<FilterBlocc>().add(UpdateFilterEvent(selectedcountries,selectedcities,selectedregions));
            context.read<DatabaseBloc>().add(FilteratabaseEvent(context,selectedcountries,selectedcities,selectedregions));
            toggleDropdown();
          },
          child: Container(color: AppColors.blackColors.withOpacity(0.7)),
        ),
        positioned(offset, renderBox,selectedcountries,selectedcities,selectedregions,(){context.read<FilterBloc>().add(FilterArrowChangeEvent());toggleDropdown();}),
      ],),);
  }

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(FetchFromDatabaseEvent());
    context.read<FilterDataBloc>().add(FetchFilterDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: size.height, width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06, top: size.width * 0.075),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    searchbar(controller: searchController, size: size, onChanged: (query) {context.read<DatabaseBloc>().add(SearchQueryChanged(query));}),
                    SizedBox(
                      width: size.width * 0.8,
                     child:BlocBuilder<FilterBlocc, FilterState>(
                        builder: (context, state) {return  Wrap(spacing: 6.0,
                      runSpacing: 2.0,
                      children: [
                        // Filter box button
                        buildGestureDetector(buttonKey,size,toggleDropdown: toggleDropdown),
                        // Chip buttons
                        ...state.selectedCountries.map((filter) => buildFilterChip(filter, selectedcountries )),
                        ...state.selectedCities.map((filter) => buildFilterChip(filter, selectedcities )),
                        ...state.selectedRegions.map((filter) => buildFilterChip(filter, selectedregions)),
                    ]);}),),
                    // List of Buisiness
                    buildBlocBuilderList(size)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chip Widget
  Widget buildFilterChip(String filter, List selectedList) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CommonText(text:filter,textAlign: TextAlign.center,fontSize: 13),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
                selectedList.remove(filter);
                context.read<FilterBlocc>().add(UpdateFilterEvent(selectedcountries,selectedcities,selectedregions));
                context.read<DatabaseBloc>().add(FilteratabaseEvent(context,selectedcountries,selectedcities,selectedregions));
                context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "region",name: selectedregions));
                // context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "region",regin: selectedregions,country: selectedcountries,city: selectedcities));
            },
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }
}
