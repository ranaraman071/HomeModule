import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_module/componenets/common_function.dart';
import 'package:home_module/data/providers/display_data/display_bloc.dart';
import 'package:home_module/data/providers/display_data/display_state.dart';
import 'package:home_module/presentation/themes/icons.dart';
import 'package:home_module/presentation/widgets/common_text.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.038),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: CommonText(text: "Contact", fontWeight: FontWeight.w600, fontSize: size.width * 0.045),
        ),
        const Divider(),
       BlocBuilder<DisplayBloc,DisplayState>(builder: (context,state){return
         state.available?
         Column(children: [
         !state.contact ? const SizedBox() : GestureDetector(onTap: (){CommonFuntion.launchDialer("+1(415)885 4605");},child: buildContainerOption(size, Icn.phone, "+1(415)885 4605")),
         !state.contact ? const SizedBox() : const Divider(),
         !state.email ? const SizedBox() : GestureDetector(onTap: (){CommonFuntion.sendEmail("examplehere@gmail.com");},child: buildContainerOption(size, Icn.email_rounded, "examplehere@gmail.com")),
         !state.email ? const SizedBox() : const Divider(),
         !state.website ? const SizedBox() : GestureDetector(onTap: (){ CommonFuntion.urlCall("https://www.centralcomputer.com/");},child: buildContainerOption(size, Icn.globe, "centralcomputers.com")),
         !state.website ? const SizedBox() : const Divider(),
         Container(
           padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
           height: size.height * 0.07,
           width: size.width,
           child: BlocBuilder<DisplayBloc,DisplayState>(builder: (context,state){
             return Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               !state.twitter?const SizedBox():GestureDetector(onTap: (){CommonFuntion.sendtoApplication("https://www.twitter.com/justinbieber/");},child: Container(color: Colors.transparent,child: Icon(Icn.twitter, size: size.height * 0.04))),
               !state.twitter?const SizedBox():SizedBox(width: size.width * 0.04),
               !state.insta ?const SizedBox():GestureDetector(onTap: (){CommonFuntion.sendtoApplication("https://www.instagram.com/justinbieber/");},child: Container(color: Colors.transparent,child: Icon(Icn.instagram, size: size.height * 0.04))),
             ],
           );}),
         ),
         SizedBox(height: size.height * 0.1)
       ]):Center(child: CommonText(text: "not available", fontSize: size.width * 0.04, fontWeight: FontWeight.w600));})
      ],
    );
  }

  Widget buildContainerOption(Size size, IconData icn, String txt) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      height: size.height * 0.07,
      width: size.width,
      child: Row(
        children: [
          Icon(icn, size: size.width * 0.08),
          SizedBox(width: size.width * 0.15),
          icn == Icn.globe ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(txt, style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurpleAccent)),
                  Container(width: size.width*0.44,height: size.width*0.004,color: Colors.deepPurpleAccent)],)
              : CommonText(text: txt, fontSize: size.width * 0.04, fontWeight: FontWeight.w600)
        ],
      ),
    );
  }
}
