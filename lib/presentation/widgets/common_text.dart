import 'package:home_module/localization/l10n/string_extension.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final String? currency;
  final Color? decorationColor;

  CommonText({
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.decoration = TextDecoration.none,
    this.fontFamily = "inter",
    this.fontStyle = FontStyle.normal,
    // this.decodeText = false,
    this.currency = "",
    this.decorationColor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // decodeText == true ? decodedText :
      currency != ""? "$currency$text" :text.tr(context),
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          fontFamily: fontFamily,
        fontStyle: fontStyle,
          decorationColor: decorationColor
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,

    );
  }
}
