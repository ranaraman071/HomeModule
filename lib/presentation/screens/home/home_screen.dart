import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/componenets/animation_navigation.dart';
import 'package:home_module/data/providers/business_data/bloc.dart';
import 'package:home_module/data/providers/business_data/state.dart';
import 'package:home_module/data/providers/display_data/display_bloc.dart';
import 'package:home_module/data/providers/display_data/display_state.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/headerBox_event.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/headerBox_state.dart';
import 'package:home_module/data/providers/home_bloc/tabBar_bloc.dart';
import 'package:home_module/data/providers/home_bloc/headerBox.bloc/upper_detail_bloc.dart';
import 'package:home_module/presentation/screens/business_gallery/business_gallery_screen.dart';
import 'package:home_module/presentation/screens/home/Widget.dart';
import 'package:home_module/presentation/screens/tabbar_screen/contact_screen.dart';
import 'package:home_module/presentation/screens/tabbar_screen/menu_screen.dart';
import 'package:home_module/presentation/screens/tabbar_screen/review_screen.dart';
import 'package:home_module/presentation/themes/color_constants.dart';
import 'package:home_module/presentation/themes/icons.dart';
import 'package:home_module/presentation/themes/images.dart';
import 'package:home_module/presentation/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  NavigationCubit? navCubit;
  AppBarBloc? appBarBloc;
  late TabController tabController;

  @override
  void initState() {
    navCubit=context.read<NavigationCubit>();
    appBarBloc=context.read<AppBarBloc>();
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this,initialIndex: navCubit!.state);

    // check scroll add listner
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        double offset = _scrollController.offset;
        double checkValue=!context.read<DisplayBloc>().state.announcement?200.0:350.0;
        if (offset > checkValue && !_isCollapsed) {
          _isCollapsed = true;
          appBarBloc!.add(AppBarCollapsed(val: true));
        } else if (offset < checkValue && _isCollapsed) {
          _isCollapsed = false;
          appBarBloc!.add(AppBarCollapsed(val: false));
        }
      }
    });
    // check tabcontroller for add listner
    tabController.addListener(() {
      if (tabController.indexIsChanging == false) {
        navCubit!.selectTab(tabController.index);
        if(!_isCollapsed &&  navCubit!.state!=1){_minimizeSliverAppBar();}
      }
    });
  }

  final List<String> tabTitles = [
    "Reviews",
    "Contact",
    "Menu", // Add or remove titles dynamically
  ];

  final double _collapsedHeight = 80.0;
  final double _expandedHeight = 600.0;
  // minimize the header to summary box by click
  void _minimizeSliverAppBar() {
     _scrollController.animateTo(
      _expandedHeight - _collapsedHeight, // Scroll to collapse
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              surfaceTintColor: AppColors.whiteColor,
              backgroundColor: AppColors.whiteColor,
              pinned: true,
              floating: false,
              expandedHeight: context.read<DisplayBloc>().state.announcement ?size.height * 0.76:size.height * 0.45,
              collapsedHeight: size.width * 0.3,
              flexibleSpace: BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
                return FlexibleSpaceBar(
                    title: GestureDetector(
                      onTap: ()async{
                        if (await Vibration.hasVibrator()) {Vibration.vibrate(duration: 200);}
                        AnimationNavigation.navigateWithAnimation(context,const BusinessGalleryScreen());},
                      child: Container(
                        height: state.val ? size.width * 0.18 : 0,
                        width: state.val ? size.width : 0,
                        margin: EdgeInsets.only(bottom: size.width * 0.12, left: size.width * 0.06, right: size.width * 0.06),
                        padding: EdgeInsets.only(left: size.width * 0.035),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundcream,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: AppColors.blackColors.withOpacity(0.25), blurRadius: 3, offset: const Offset(-1, 5)),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.08,
                              height: size.width * 0.08,
                              margin: EdgeInsets.only(bottom: size.width * 0.02),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(AssetsPics.images))),
                            SizedBox(width: size.width * 0.03),
                            BlocBuilder<DataDisplayBloc,DataFetchState>(builder: (context,state){return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: size.width * 0.03),
                                CommonText(text: state.buisinessName, color: AppColors.blackColors, fontSize: size.width * 0.04, fontWeight: FontWeight.w600),
                                SizedBox(height: size.width * 0.015),
                                Row(
                                  children: [
                                    CommonText(text: state.opened, color: state.opened=="Closed"? AppColors.redColors:AppColors.greenColors, fontSize: size.width * 0.035, fontWeight: FontWeight.w600),
                                    SizedBox(width: size.width * 0.03),
                                    CommonText(text: state.opentiming, color: AppColors.blackColors, fontSize: size.width * 0.03, fontWeight: FontWeight.w600),
                                  ],),],
                            );}),
                            SizedBox(width: size.width * 0.2),
                            Container(color:AppColors.transparentColors,
                              child: Icon(Icn.adress, size: size.width * 0.08),
                            )],),
                      ),
                    ),
                    centerTitle: true,
                    background: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       CommonWidget.headerImage(size,context),
                        CommonWidget.buildDescriptionContainer(size),
                        CommonWidget.buildAdressContainer(size),
                        BlocBuilder<DisplayBloc,DisplayState>(builder: (context,state){return state.announcement?  CommonWidget.buildAnnouncementContainer(size):const SizedBox();})
                      ],
                    ));
              }),
              bottom: TabBar(
                onTap: (index){
                  navCubit!.selectTab(index);
                  if(index!=1 && !_isCollapsed){_minimizeSliverAppBar();}},
                controller: tabController,
                indicatorColor: AppColors.redColors,
                indicatorWeight: 1,
                labelColor: AppColors.blackColors,
                labelStyle: TextStyle(color: AppColors.blackColors, fontSize: size.width * 0.04, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 2.0,
                splashFactory: NoSplash.splashFactory,
                unselectedLabelColor: AppColors.blackColors,
                tabs: tabTitles.map((title) => Tab(text: title)).toList()),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return BlocBuilder<NavigationCubit,int>(builder: (context,state){
                  return Column(children: [
                    SizedBox(
                      height: size.height*0.8,
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          ReviewScreen(),
                          ContactScreen(),
                          MenuScreen(),
                        ],
                      ),
                    ),
                  ]);
                });
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}
