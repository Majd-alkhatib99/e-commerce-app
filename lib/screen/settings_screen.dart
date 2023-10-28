import 'package:ecommerce/cubit/main/main_cubit.dart';
import 'package:ecommerce/shared/components/components.dart';
import '../shared/style/color.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/icons.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit= MainCubit.get(context);
        return Scaffold(
          backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
          appBar: AppBar(
            backgroundColor: cubit.isDarkMode
                ?secondColorDark
                :secondColorLight ,
            elevation: 0.0,
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0,),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('http://192.168.43.142:8000/images/categories/1692436077.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width*0.02,),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: cubit.userModel!.name,
                          isBold: true,
                          fontSize: 20.0,
                          color: cubit.isDarkMode?whiteColor:blackColor,
                        ),
                        SizedBox(height: size.height*0.02,),
                        CustomText(
                          text: cubit.userModel!.email,
                          fontSize: 18.0,
                          color: cubit.isDarkMode?greyColor:greyColor2,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: size.height*0.2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     CustomText(
                      text: cubit.isDarkMode?'light Mode':'Dark Mode',
                      isBold: true,
                      fontSize: 20.0,
                         color: cubit.isDarkMode?whiteColor:blackColor,
                    ),
                    Switch(
                      value: cubit.isDarkMode,
                      onChanged:(value)=>cubit.convertMode(),
                      activeColor: cubit.isDarkMode?primeColorDark:primeColorDark,
                      // activeTrackColor: cubit.isDarkMode?secondColorDark:secondColorLight,

                    )
                  ],
                ),
                SizedBox(height: size.height*0.05,),
                InkWell(
                  onTap: ()=>cubit.logOut(context,cubit.token),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Logout',
                        isBold: true,
                        fontSize: 20.0,
                        color: cubit.isDarkMode?whiteColor:blackColor,
                      ),
                      Icon(
                          Icons.logout,
                        color: cubit.isDarkMode?primeColorDark:primeColorLight,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
