import '../shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_text.dart';

class CustomTextFormField  extends StatelessWidget {
  final String text;
  final String hint;
  final Function onSave;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Widget? icon;
  final Color textColor;
  final Color color;
  final Color primeColor;

  const CustomTextFormField ({
    Key? key,
    this.textColor=whiteColor,
    this.color=greyColor,
    this.primeColor=primeColorDark,
    this.icon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    required this.textEditingController,
    required  this.text,
    required this.hint,
    required this.onSave,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text,
          fontSize: 14,
          color: textColor,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: textEditingController,
          keyboardType: textInputType,
          style:  GoogleFonts.ubuntu(
            textStyle: TextStyle(
                color: textColor
            ),
          ),
          validator:validator,
          onSaved: (value) => onSave(),

          decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hint,
            hintStyle:  TextStyle(
              color:color,
            ),
            fillColor: Colors.white,
            disabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: color),
    ),
            border:  UnderlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: color),
            ),
            focusedBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: primeColor),
            ),

          ),
        )
      ],
    );
  }
}
