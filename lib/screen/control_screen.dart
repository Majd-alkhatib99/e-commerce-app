import 'package:ecommerce/screen/settings_screen.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/main/main_cubit.dart';
import '../shared/style/color.dart';
import '../widget/custom_bottom_navigation_bar.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state){
        String token = CacheHelper.getData(key: 'token');
        var cubit = MainCubit.get(context);
        return  Scaffold(
          backgroundColor: cubit.isDarkMode
              ?secondColorDark
              :secondColorLight ,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness:cubit.isDarkMode?Brightness.light:Brightness.dark,
              statusBarColor: cubit.isDarkMode?secondColorDark:secondColorLight,
              statusBarIconBrightness: cubit.isDarkMode?Brightness.light:Brightness.dark,
            ),
            elevation: 0,
            title: CustomText(
              fontSize: 20.0,
              isBold: true,
              text: cubit.appBarTitle[cubit.navIndex],
              color: cubit.isDarkMode?whiteColor:blackColor,
            ),
            backgroundColor: cubit.isDarkMode
                ?secondColorDark
                :secondColorLight ,
            actions: [
              IconButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsScreen())),
                  icon: cubit.isDarkMode
                          ?const Icon(Icons.settings,color: primeColorDark,)
                          :const Icon(Icons.settings,color: primeColorLight,) )
            ],
          ),
          body: cubit.screens[cubit.navIndex],
          bottomNavigationBar: CustomNavBar(
            onTap:(index)=>cubit.changeNavIndex(index),
            isDark: cubit.isDarkMode,
            currentIndex: cubit.navIndex,
            backGroundColor:cubit.isDarkMode
                ?secondColorDark
                :secondColorLight ,
            selectedIconColor: cubit.isDarkMode
                ?primeColorDark
                :primeColorLight,
            unSelectedIconColor:  cubit.isDarkMode
                ?greyColor
                :greyColor2,

          ),
        );
      },
    );
  }




}
