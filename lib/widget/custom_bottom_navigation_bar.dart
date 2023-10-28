import 'package:ecommerce/shared/components/icons.dart';
import 'package:flutter/material.dart';
import '../shared/style/color.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Color backGroundColor;
  final Color selectedIconColor;
  final Color unSelectedIconColor;
  final Function onTap;
  final bool isDark;

   const CustomNavBar({
    Key? key,
    required this.currentIndex,
    this.isDark=true,
    required this.onTap,
    this.backGroundColor=secondColorDark,
    this.selectedIconColor=primeColorDark,
    this.unSelectedIconColor=greyColor
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> darkSelectedIcon=[
      CustomIcon.homeDarkActive,
      CustomIcon.cartDarkActive,
      CustomIcon.starDarkActive,
    ];
    List<String> darkUnSelectedIcon=[
      CustomIcon.homeDarkDeActive,
      CustomIcon.cartDarkDeActive,
      CustomIcon.starDarkDeActive,
    ];
    List<String> lightSelectedIcon=[
      CustomIcon.homeLightActive,
      CustomIcon.cartLightActive,
      CustomIcon.starLightActive,
    ];
    List<String>lightUnSelectedIcon=[
      CustomIcon.homeLightDeActive,
      CustomIcon.cartLightDeActive,
      CustomIcon.starLightDeActive,
    ];
    return Container(
      margin: const EdgeInsets.all(20),
      height: size.width * .155,
      width: size.width ,
      decoration: BoxDecoration(
        color: backGroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * .024),
        itemBuilder: (context, index) => InkWell(
          onTap: () => onTap(index),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:10),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .160,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration:  BoxDecoration(
                    color:selectedIconColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Image.asset(
                   isDark
                       ?index == currentIndex
                          ?darkSelectedIcon[index]
                          :darkUnSelectedIcon[index]
                       :index == currentIndex
                          ?lightSelectedIcon[index]
                          :lightUnSelectedIcon[index],
                  width:size.width * .076 ,
                  height:size.width * .076 ,
                ),
                 SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
