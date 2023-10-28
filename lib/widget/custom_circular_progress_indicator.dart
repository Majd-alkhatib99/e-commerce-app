import 'package:flutter/material.dart';

import '../shared/style/color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final bool isDarkMode;
  const CustomCircularProgressIndicator({super.key,this.isDarkMode=true});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      color: isDarkMode
          ?primeColorDark
          :primeColorLight,
    ),);
  }
}
