import 'package:cached_network_image/cached_network_image.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/database_state.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_bloc.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_sort_button/filter_sort_button_state.dart';
import 'package:database_task/presentation/themes/color_constants.dart';
import 'package:database_task/presentation/themes/font_family.dart';
import 'package:database_task/presentation/widgets/common_text.dart';
import 'package:database_task/utils/google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Search box widget
Widget searchbar({required TextEditingController controller,required Size size,void Function(String)? onChanged, void Function()? onTap}){
  return Container(
    height: size.width*0.11,
    margin: EdgeInsets.only(left: size.width*0.06, right: size.width*0.06, top: size.width*0.06, bottom: size.width*0.055),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: AppColors.transparentColors),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: AppColors.transparentColors),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: AppColors.transparentColors),
        ),
        suffixIcon:  Padding(
            padding: const EdgeInsets.only(right: 20,bottom: 0),
            child: GestureDetector(
              onTap: () {
                print('Searching: ${controller.text}');
              },
              child: Icon(
                Icons.search,
                size: size.width*0.09,
              ),
            )

        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0,),
      ),
      // Use constraints to limit height
      style: TextStyle(fontSize: size.width*0.04),
      textAlignVertical: TextAlignVertical.center, // Align text vertically in the middle
    ),
  );
}

// Buisiness result widget
BlocBuilder<DatabaseBloc, DatabaseState> buildBlocBuilderList(Size size) {return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state1) {
    if (state1 is DataLoadedState) {
      List<Map<String, dynamic>> data = List.from(state1.data);
      if (data.length == 0) {
        return Container(
          margin: const EdgeInsets.only(top: 50),
          child: Center(
            child: CommonText(
              text: "No Result",
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        );
      } else {
        return BlocBuilder<FilterBloc, FilterArrowState>(
            builder: (context, state) {
              if (state.val == "down") {data.sort((a, b) => DateTime.parse(a['time'].toString()).compareTo(DateTime.parse(b['time'].toString())));}
              else if (state.val == "up") {data.sort((a, b) => DateTime.parse(b['time'].toString()).compareTo(DateTime.parse(a['time'].toString())));}
              else if (state.val == "updown") {data = List.from(state1.data);}

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: size.width * 0.025),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String location =
                  data[index]["country"].toString().toLowerCase() == "us" ? "${data[index]["city"]},${data[index]["state"]}" : "${data[index]["city"]},${data[index]["country"]}";
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.025, horizontal: size.width * 0.012),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: size.width * 0.201,
                          width: size.width * 0.62,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                            color: Colors.grey.shade50,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset: const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.04),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data[index]["profilepic"] == null || data[index]["profilepic"] == "" ? const SizedBox() : Padding(
                                  padding: EdgeInsets.only(top: size.width * 0.04, right: size.width * 0.04),
                                  child: Container(
                                    height: size.width * 0.08,
                                    width: size.width * 0.08,
                                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(imageUrl: data[index]["profilepic"].toString(), fit: BoxFit.cover)
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(text:data[index]["name"] ?? "",fontSize: size.width * 0.046, fontFamily: FontFamily.arial, fontWeight: FontWeight.w700),
                                    CommonText(text:data[index]["score"].toString() ?? "",fontSize: size.width * 0.04, fontFamily: FontFamily.arial, fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                openGoogleMaps(data[index]["latitude"].toString(), data[index]["longitude"].toString());
                              },
                              child: Container(
                                height: size.width * 0.166,
                                width: size.width * 0.19,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  color: AppColors.purple,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(CupertinoIcons.placemark, size: size.width * 0.085),
                              ),
                            ),
                            SizedBox(height: size.width * 0.013),
                            Container(
                                alignment: Alignment.center,
                                width: size.width * 0.19,
                                child: CommonText(text: location,
                                  fontSize: size.width * 0.02, color: AppColors.grey, fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, maxLines: 2))
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      }
    }
    return const SizedBox();
  });}

// Filter Button widget
GestureDetector buildGestureDetector(GlobalKey buttonKey,Size size,{GestureTapCallback? toggleDropdown}) {
  return GestureDetector(
    key: buttonKey,
    onTap:toggleDropdown,
    child: Container(
      margin: const EdgeInsets.only(left: 5, bottom: 10),
      height: size.width * 0.07,
      width: size.width * 0.38,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(width: size.width * 0.02),
          Icon(Icons.arrow_drop_down_sharp, size: size.width * 0.07, color: Colors.grey[700]),
          CommonText(text: "Filters", fontSize: size.width * 0.04, color: AppColors.blackColors, fontWeight: FontWeight.w600, fontFamily: FontFamily.arialItalic),
        ],
      ),
    ),
  );
}