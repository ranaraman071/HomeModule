import 'package:flutter/material.dart';
import 'package:home_module/presentation/widgets/common_text.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Center(
      child: CommonText(
        text: "Reviews Content",
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Container buildContainerOption(Size size,IconData icn,String txt) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
      height: size.height*0.07,
      width: size.width,
      child:  Row(
        children: [
          Icon(icn,size: size.width*0.08),
          SizedBox(width: size.width*0.15),
          CommonText(text: txt,fontSize: size.width*0.04,fontWeight: FontWeight.w600,)
        ],),
    );
  }
}
