import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final int maxLine;
  final double height;
  final bool isBold;
  final bool isUnderLine;


  const CustomText({
    Key? key,
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLine=1,
    this.height = 1,
    this.isBold=false,
    this.isUnderLine=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
          textStyle:  TextStyle(
            decoration: isUnderLine?TextDecoration.underline:TextDecoration.none,
            fontWeight: isBold?FontWeight.bold:FontWeight.normal,
            color: color,
            height: height,
            fontSize: fontSize,
          )
        ),
        maxLines: maxLine,
      ),
    );
  }
}
