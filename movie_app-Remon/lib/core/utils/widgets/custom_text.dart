import 'package:flutter/material.dart';
import 'package:movie_app/core/responsive/inject_resposive_info.dart';
import 'package:movie_app/core/theme/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLine, this.textAlign, 
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLine;
  final TextAlign?  textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(

          overflow: TextOverflow.ellipsis,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? AppColors.white),
      maxLines: maxLine,
    );
  }
}
