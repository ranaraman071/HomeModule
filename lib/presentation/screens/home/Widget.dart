import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_module/componenets/animation_navigation.dart';
import 'package:home_module/componenets/common_function.dart';
import 'package:home_module/data/providers/animation_cubit/animation_bloc.dart';
import 'package:home_module/data/providers/animation_cubit/animation_event.dart';
import 'package:home_module/data/providers/animation_cubit/animation_state.dart';
import 'package:home_module/data/providers/business_data/bloc.dart';
import 'package:home_module/data/providers/business_data/state.dart';
import 'package:home_module/presentation/screens/business_gallery/business_gallery_screen.dart';
import 'package:home_module/presentation/themes/color_constants.dart';
import 'package:home_module/presentation/themes/icons.dart';
import 'package:home_module/presentation/themes/images.dart';
import 'package:home_module/presentation/widgets/common_text.dart';
import 'package:home_module/presentation/widgets/common_url.dart';
import 'package:home_module/utils/navigator_services.dart';

class CommonWidget{

  // Header Images area
  static Widget headerImage(Size size,BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.3,
      color: AppColors.redColors,
      child: GestureDetector(
        onTap: () {
          NavigatorService().push(const BusinessGalleryScreen());
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AssetsPics.cyb, fit: BoxFit.cover),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.blackColors.withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BlocBuilder<DataDisplayBloc,DataFetchState>(builder: (context,state){return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonText(
                          text: state.buisinessName,
                          color: AppColors.whiteColor,
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600),
                      SizedBox(height: size.width * 0.015),
                      Row(
                        children: [
                          CommonText(
                              text: state.opened,
                              color:state.opened=="Closed"? AppColors.redColors:AppColors.greenColors,
                              fontSize: size.width * 0.038,
                              fontWeight: FontWeight.w600),
                          SizedBox(width: size.width * 0.05),
                          CommonText(
                              text: state.opentiming,
                              color: AppColors.whiteColor,
                              fontSize: size.width * 0.03,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    ],
                  );}),
                  GestureDetector(
                    onTap: () {
                      AnimationNavigation.navigateWithAnimation(context,const BusinessGalleryScreen());
                    },
                    child: Container(
                        color: AppColors.transparentColors,
                        child: Icon(Icn.camera_alt_outlined, color: AppColors.whiteColor, size: size.width * 0.08)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // One line Desciption area
  static   Widget buildDescriptionContainer(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      height: size.width * 0.1,
      width: size.width,
      child: CommonText(
        text: "Computer Store,Electronic etc. [Store Description]",
        fontSize: size.width * 0.037,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Adress containter
  static Widget buildAdressContainer(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.15,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.width * 0.01),
      child:  BlocBuilder<AnimationBloc,AnimationState>(builder: (context,state){return DottedBorder(
        color:state.val? AppColors.blackColors:AppColors.transparentColors,
        strokeWidth: 2,
        radius: const Radius.circular(5),
        borderType: BorderType.RRect,
        stackFit: StackFit.loose,
        dashPattern:const [3, 3],
        child: TextFormField(
          readOnly: true,
          onTap: () {
            context.read<AnimationBloc>().add(AnimateEvent(val: true));
            CommonFuntion.urlCall(CommonUrl.googleMap);
          },
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icn.adress, size: size.width * 0.08),
              hintText: "Address",
              hintStyle: TextStyle(fontSize: size.width * 0.04)),
        ),
      );}),
    );
  }

  // Announcement container with bool condition
  static   Widget buildAnnouncementContainer(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.width * 0.02),
      height: size.height * 0.32,
      width: size.width,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: size.height * 0.22,
            padding: EdgeInsets.only(left: size.width*0.04),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: [
                Positioned(top: size.width*0.01, left:size.width* -0.004, right:  size.width*0.01, bottom: size.width* -0.004, child: SvgPicture.asset(AssetsPics.shape,height: size.width,   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcATop),)),
                SvgPicture.asset(AssetsPics.shape,height: size.width),
                Container(
                    margin: EdgeInsets.only(left: size.width*0.07,right: size.width*0.045),
                    alignment: Alignment.center,
                    height: size.height*0.2,
                    width: size.height*0.4,
                    child: CommonText(text: "Announcements ", fontSize: size.width * 0.04, fontWeight: FontWeight.w600,maxLines: 7,overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.1,
                height: size.width * 0.1,
                decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
                child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),child: Image.asset(AssetsPics.images)),
              ),
              CommonText(
                text: "Last Updated 3/3/24",
                color: AppColors.grey,
                fontSize: size.width * 0.034,
                fontStyle: FontStyle.italic,
              )
            ],
          ),
        ],
      ),
    );
  }
}