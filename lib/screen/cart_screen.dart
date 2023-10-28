import 'package:ecommerce/cubit/main/main_cubit.dart';

import 'package:ecommerce/widget/custom_buttom.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../shared/style/color.dart';
import '../widget/custom_circular_progress_indicator.dart';

class CartScreen extends StatelessWidget {
   const CartScreen({Key? key}) : super(key: key);
   final int count=0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=MainCubit.get(context);
        if((cubit.cartModel!.isEmpty||state is LoadingGetCart)&& state is ChangeNavIndexState){
          return CustomCircularProgressIndicator(isDarkMode: cubit.isDarkMode);
        }else{
          if(cubit.cartModel!.isNotEmpty||state is SuccessRemoveProductFromCart){
            return buildCartScreen(cubit,size);
          }else {
            return Center(child:  CustomText(
              text: 'The cart is empty',
              color: cubit.isDarkMode?whiteColor:primeColorLight,
              isBold: true,
              fontSize: 20.0,
              alignment: Alignment.center,
            ));
          }
        }

      },
    );
  }

  Widget buildCartScreen(MainCubit cubit,size){

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index){



                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Dismissible(
                      onDismissed: (element){
                        cubit.removeProductFromCart(token: cubit.token, id: cubit.cartModel![index].id!);
                      },
                      background: Container(
                        color: Colors.red,
                        // padding: const EdgeInsets.symmetric( vertical: 10.0),
                        child:  const Padding(
                          padding:  EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Icon(Icons.delete_outline_outlined,color: whiteColor),
                            ],
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                '${cubit.imagePath}${cubit.cartModel![index].photo}',
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: size.width * 0.02,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: cubit.cartModel![index].name!,
                                      color: cubit.isDarkMode ? whiteColor : blackColor,
                                      maxLine: 2,
                                    ),
                                    SizedBox(height: size.height * 0.02,),
                                    CustomText(
                                      text: '${cubit.cartModel![index].price}\$',
                                      color: cubit.isDarkMode ? primeColorDark : primeColorLight,
                                    ),
                                    SizedBox(height: size.height * 0.02,),

                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index)=>const SizedBox(height: 0,),
                itemCount: cubit.cartModel!.length
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Column(
                children:  [
                  CustomText(
                    text: 'Total:',
                    color: cubit.isDarkMode?whiteColor:blackColor,
                    isBold: true,
                    fontSize: 20.0,

                  ),
                  SizedBox(height: size.height*0.01,),
                  CustomText(
                    text: '0\$',
                    color: cubit.isDarkMode?primeColorDark:primeColorLight,
                    fontSize: 18.0,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 100.0,
                width: 180.0,
                child: CustomButton(
                  onPress: (){},
                  text: 'Check Out',
                  fontSize: 18.0,
                  color: cubit.isDarkMode?primeColorDark:primeColorLight,
                  textColor: cubit.isDarkMode?secondColorDark:secondColorLight,

                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
