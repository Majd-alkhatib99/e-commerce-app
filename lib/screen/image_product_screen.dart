import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main/main_cubit.dart';
import '../shared/style/color.dart';
import '../shared/components/icons.dart';

class ImageProductScreen extends StatelessWidget {
  final String imagePath;
  const ImageProductScreen({Key? key,this.imagePath='',}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
    // TODO: implement listener
  },
      builder: (context, state) {
        var cubit=MainCubit.get(context);
    return Scaffold(
      backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness:cubit.isDarkMode?Brightness.light:Brightness.dark,
          statusBarColor: cubit.isDarkMode?secondColorDark:secondColorLight,
          statusBarIconBrightness: cubit.isDarkMode?Brightness.light:Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            cubit.isDarkMode?CustomIcon.arrowBackDark:CustomIcon.arrowBackLight,
            fit: BoxFit.fill,
            height: 30,
            width: 30,
          ),
        ),
        backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
        elevation: 0,

      ),
      body: Center(
        child: Image.network(imagePath),
      ),
    );
  },
);
  }
}
