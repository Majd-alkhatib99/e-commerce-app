import 'package:ecommerce/cubit/main/main_cubit.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/style/color.dart';
import '../widget/custom_circular_progress_indicator.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;

    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit=MainCubit.get(context);
    if((cubit.favModel!.isEmpty||state is LoadingGetFav)&& state is ChangeNavIndexState){
      return CustomCircularProgressIndicator(isDarkMode: cubit.isDarkMode);
    }else{
      if(cubit.favModel!.isNotEmpty||state is SuccessRemoveProductFromFav){
        return buildFavScreen(cubit,size);
      }else {
        return Center(child:  CustomText(
          text: 'Wish List is empty',
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
  Widget buildFavScreen(MainCubit cubit ,size){
    return SizedBox(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Dismissible(
                onDismissed: (element){
                  cubit.removeProductFromFav(token: cubit.token, id: cubit.cartModel![index].id!);
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
                          '${cubit.imagePath}${cubit.favModel![index].photo}',
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
                                text: cubit.favModel![index].name!,
                                color: cubit.isDarkMode ? whiteColor : blackColor,
                                maxLine: 2,
                              ),
                              SizedBox(height: size.height * 0.02,),
                              CustomText(
                                text: '${cubit.favModel![index].price}\$',
                                color: cubit.isDarkMode ? primeColorDark : primeColorLight,
                              ),


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
          itemCount: cubit.favModel!.length
      ),);
  }
}
