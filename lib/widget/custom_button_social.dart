import '../shared/style/color.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial  extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPress;
  final Color color;

   const CustomButtonSocial ({
     Key? key,
     required this.text,
     required this.imageName,
     required this.onPress,
     this.color=secondColorLight,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color:whiteColor,
      ),
      child: OutlinedButton(

        onPressed:()=> onPress,
        style:  OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageName,height: 18,width: 18,),
            const SizedBox(
              width: 10,
            ),
            CustomText(
               alignment: Alignment.center,
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}
