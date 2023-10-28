import 'package:ecommerce/cubit/main/main_cubit.dart';
import 'package:ecommerce/screen/image_product_screen.dart';
import '../model/products_model.dart';
import '../shared/style/color.dart';
import 'package:ecommerce/shared/components/icons.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/custom_buttom.dart';

class ProductDetailsScreen2 extends StatelessWidget {

  final ProductsDataModel productDetails;
  const ProductDetailsScreen2( {Key? key,required this.productDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=MainCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: cubit.isDarkMode
                ?secondColorDark
                :secondColorLight,
            body: Column(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=>ImageProductScreen(
                                  imagePath:  cubit.imagePath+productDetails.photo!,
                                )));
                      },
                      child: SizedBox(
                        width: size.width,
                        height: 300,
                        child: Image.network(
                          cubit.imagePath+productDetails.photo!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(

                              backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5,bottom: 3),
                                child: Image.asset(
                                  cubit.isDarkMode?CustomIcon.arrowBackDark:CustomIcon.arrowBackLight,
                                  fit: BoxFit.fill,
                                  height: 30.0,
                                  width: 30.0,

                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>cubit.addProductToFav(token: cubit.token, id: productDetails.id!),
                            child: CircleAvatar(
                              // radius: 20,
                              backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
                              child: Image.asset(
                                cubit.isDarkMode?CustomIcon.starDarkDeActive:CustomIcon.starLightDeActive,
                                fit: BoxFit.cover,
                                height: 26.0,
                                width: 26.0,

                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          CustomText(
                            text: productDetails.name!,
                            isBold: true,
                            fontSize: 20.0,
                            color: cubit.isDarkMode?whiteColor:blackColor,
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                width: size.width * .4,
                                height: size.height * .065,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: cubit.isDarkMode?greyColor:greyColor2,
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:  [
                                    CustomText(
                                      text: 'Size',
                                      color: cubit.isDarkMode?whiteColor:blackColor,
                                    ),
                                    Container(
                                      width: 1,
                                      color: cubit.isDarkMode?whiteColor:blackColor,
                                    ),
                                    CustomText(
                                      text: '22',
                                      color: cubit.isDarkMode?whiteColor:blackColor,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                width: size.width * .4,
                                height:size.height * .065,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: cubit.isDarkMode?greyColor:greyColor2,
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: 'Color',
                                      color: cubit.isDarkMode?whiteColor:blackColor,
                                    ),
                                    Container(
                                      width: 1,
                                      color: cubit.isDarkMode?whiteColor:blackColor,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 20,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.amber,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            text: 'Details',
                            fontSize: 18,
                            isBold: true,
                            color: cubit.isDarkMode?whiteColor:blackColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            maxLine: 7,
                            text: productDetails.description!,
                            fontSize: 18,
                            height: 2.5,
                            color: cubit.isDarkMode?whiteColor:blackColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Price:",
                            fontSize: 18,
                            isBold: true,
                            color: cubit.isDarkMode?whiteColor:blackColor,
                          ),
                          CustomText(
                            text: ' ${productDetails.price!}\$',
                            color: cubit.isDarkMode?primeColorDark:primeColorLight,
                            fontSize: 18,
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: 180,
                        height: 80,
                        child: CustomButton(
                          onPress: ()=>cubit.addProductToCart(token: cubit.token, id: productDetails.id!),
                          text: 'Add To Cart',
                          textColor: cubit.isDarkMode?blackColor:whiteColor,
                          color: cubit.isDarkMode?primeColorDark:primeColorLight,
                        ),
                      ),
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
