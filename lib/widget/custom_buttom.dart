import '../shared/style/color.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function onPress;
  final double fontSize;
  const CustomButton({
    Key? key,
    required this.onPress,
    this.fontSize=16.0,
    this.text= 'text',
    this.color=Colors.white,
    this.textColor=secondColorDark
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(88, 36),

          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
          onPressed:()=>onPress(),
          child: CustomText(
            alignment: Alignment.center,
            text: text,
            color: textColor,
            fontSize: fontSize,
          ),
      ),
    );
  }
}
