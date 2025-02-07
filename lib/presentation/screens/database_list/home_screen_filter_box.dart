import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_state.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_state.dart';
import 'package:database_task/presentation/themes/color_constants.dart';
import 'package:database_task/presentation/widgets/common_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Filter Box
Positioned positioned(Offset offset, RenderBox renderBox,List selectedcountries,List selectedcities,List selectedregions  ,GestureTapCallback ontap, ) {
  return Positioned(
    left: offset.dx,
    top: offset.dy + renderBox.size.height,
    width: renderBox.size.width * 2,
    child: Material(
      color: AppColors.transparentColors,
      child: Container(
        width: 400,
        height: 400,
        padding: const EdgeInsets.only(top: 15, left: 20, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1)],
        ),
        child: Theme(
          data: ThemeData(highlightColor: Colors.red.shade200),
          child: Scrollbar(
            thickness: 6.0,
            radius: const Radius.circular(10),
            child: StatefulBuilder(
              builder: (context, setStateOverlay) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(left: 4),
                        child: CommonText(text: "Filters",fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: GestureDetector(
                                  onTap: ontap,
                                  child: Container(width: 50,
                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.transparentColors,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1.5, color: AppColors.grey)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time_rounded, size: 14),
                                        const SizedBox(width: 5),
                                        BlocBuilder<FilterBloc, FilterArrowState>(builder: (context, state) {
                                          return state.val == "updown" ? const Icon(CupertinoIcons.arrow_up_arrow_down, size: 12) : state.val == "up"
                                              ? const Icon(CupertinoIcons.arrow_up, size: 12) : const Icon(CupertinoIcons.arrow_down, size: 12);
                                        })],),),),),),
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              margin: const EdgeInsets.only(bottom: 6,right: 25),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.blackColors, width: 1.0))),
                              child: CommonText(text: "Country",fontSize: 15, fontWeight: FontWeight.w900),
                            ),
                            BlocBuilder<FilterDataBloc, FilterDataLoadeddState>(builder: (context, state) {
                              return Column(
                                children: state.countriesData.map((countryData) {
                                  String countryName=countryData.split(",")[0];
                                  String countryCount=state.countryFilterMap.firstWhere((city) => city['country'] == countryName, orElse: () => {'countryCount': 0})['countryCount'].toString();
                                  return Row(
                                    children: [
                                      Transform.scale(scale: 0.9, child: Theme(
                                        data: ThemeData(checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(AppColors.whiteColor),
                                          checkColor: MaterialStateProperty.all(AppColors.blackColors))),
                                        child: Checkbox(
                                          value: selectedcountries.contains(countryData),
                                          onChanged: (bool? value) {
                                            setStateOverlay(() {
                                              if (selectedcountries.contains(countryData)) {selectedcountries.remove(countryData);} else {selectedcountries.add(countryData);}
                                            });
                                            context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "country",name: selectedcountries));
                                          },
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setStateOverlay(() {
                                              if (selectedcountries.contains(countryData)) {selectedcountries.remove(countryData);} else {selectedcountries.add(countryData);}
                                            });
                                            context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "country",name: selectedcountries));
                                          },
                                          child: Container(width: 180, color: AppColors.transparentColors, child:
                                          CommonText(text: "$countryData ($countryCount)",fontSize: 14, fontWeight: FontWeight.w600))),
                                    ],);
                                }).toList(),);}),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              margin: const EdgeInsets.only(bottom: 6,right: 25),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.blackColors, width: 1.0))),
                              child: CommonText(text:"City", fontSize: 15, fontWeight: FontWeight.w600),),
                            BlocBuilder<FilterDataBloc, FilterDataLoadeddState>(builder: (context, state) {
                              return Column(
                                children: state.citiesData.map((cityData) {
                                  String cityName="";
                                  String countryName="";
                                  String cityCount="";
                                  String textData = "";
                                  List<String> cityParts = cityData.split(",");
                                  if (cityParts.length == 1) {
                                    cityName=cityData.split(",")[0];
                                    cityCount = state.cityFilterMap.firstWhere((city) => city['city'] == cityName, orElse: () => {'cityCount': 0})['cityCount'].toString();
                                  } else {
                                    cityName=cityData.split(",")[0];
                                    countryName = cityData.split(",")[1].trim();
                                    cityCount = state.cityFilterMap.firstWhere((city) => city['city'] == cityName && city['country'] == countryName, orElse: () => {'cityCount': 0})['cityCount'].toString();
                                  }
                                  if(state.citiesCopiesData.contains(cityData)) {textData =  "${cityData.split(',')[0]} ($cityCount)";  ;}
                                  else {textData = "${cityData.replaceAll(",", " ")} ($cityCount)";}
                                  return Row(
                                    children: [
                                      Transform.scale(scale: 0.9, child: Theme(
                                        data: ThemeData(checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(AppColors.whiteColor),
                                            checkColor: MaterialStateProperty.all(AppColors.blackColors))),
                                        child: Checkbox(
                                          value: selectedcities.contains(cityData),
                                          onChanged: (bool? value) {
                                            setStateOverlay(() {
                                              if (selectedcities.contains(cityData)) {selectedcities.remove(cityData);} else {selectedcities.add(cityData);}
                                            });
                                            context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "city",name: selectedcities));
                                          },
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setStateOverlay(() {
                                              if (selectedcities.contains(cityData)) {selectedcities.remove(cityData);} else {selectedcities.add(cityData);}
                                            });
                                            context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "city",name: selectedcities));
                                          },
                                          child: Container(width: 180, color: AppColors.transparentColors, child:
                                          // CommonText(text:"${cityData.replaceAll(",", " ")} ($cityCount)", fontSize: 14, fontWeight: FontWeight.w600))),
                                          CommonText(text: textData, fontSize: 14, fontWeight: FontWeight.w600))),
                                    ],
                                  );
                                }).toList(),
                              );
                            }),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              margin: const EdgeInsets.only(bottom: 6,right: 25),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.blackColors, width: 1.0))),
                              child: CommonText(text: "Region", fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            BlocBuilder<FilterDataBloc, FilterDataLoadeddState>(
                                builder: (context, state) {
                                  return Column(
                                    children: state.regions.map((region) {
                                      String regionName=region.split(",")[0];
                                      String regionCount=state.regionFilterMap.firstWhere((region) => region['region'] == regionName, orElse: () => {'regionCount': 0})['regionCount'].toString();
                                      return Row(children: [
                                          Transform.scale(scale: 0.9,
                                            child: Theme(
                                              data: ThemeData(
                                                checkboxTheme: CheckboxThemeData(
                                                  fillColor: MaterialStateProperty.all(AppColors.whiteColor),
                                                  checkColor: MaterialStateProperty.all(AppColors.blackColors))),
                                              child: Checkbox(
                                                value: selectedregions.contains(region),
                                                onChanged: (bool? value) {
                                                  setStateOverlay(() {
                                                    if (selectedregions.contains(region)) {selectedregions.remove(region);} else {selectedregions.add(region);}
                                                  });
                                                  context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "region",name: selectedregions));
                                                },
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),),),
                                          GestureDetector(
                                              onTap: () async {
                                                setStateOverlay(() {
                                                  if (selectedregions.contains(region)) {selectedregions.remove(region);} else {selectedregions.add(region);}});
                                                context.read<FilterDataBloc>().add(FetchDataWithRegionEvent(region: "region",name: selectedregions));},
                                              child: Container(width: 180, color: AppColors.transparentColors, child: CommonText(text: "$region ($regionCount)",fontSize: 14, fontWeight: FontWeight.w600))),],);
                                    }).toList(),);}),],),),),
                    const Icon(Icons.arrow_drop_down, size: 50),],);},),),),),),);
}