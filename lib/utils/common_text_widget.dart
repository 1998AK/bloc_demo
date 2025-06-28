import 'package:bloc_demo/utils/app_color.dart';
import 'package:bloc_demo/utils/screen_width_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget({super.key,required this.text,this.fontSize,this.fontWeight,this.color,this.textAlign});
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
            fontSize: sizeOfReturnValue(size: fontSize ?? 16),
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? Colors.black
        ));
  }
}

class CommonButtonTextWidget extends StatelessWidget {
  const CommonButtonTextWidget({super.key,required this.text,this.fontSize,this.fontWeight,this.color,this.textAlign});
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
            fontSize: sizeOfReturnValue(size: fontSize ?? 14),
            fontWeight: fontWeight ?? FontWeight.w600,
            color: color ?? whiteColor
        ));
  }
}