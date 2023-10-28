import 'package:ecommerce/screen/product_details_screen.dart';
import 'package:ecommerce/screen/product_details_screen2.dart';
import 'package:ecommerce/widget/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/main/main_cubit.dart';
import '../shared/components/icons.dart';
import '../shared/style/color.dart';
import '../widget/custom_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(

              children: [
                buildSearchBar(cubit),
                SizedBox(height: size.height*0.01,),
                state is LoadingSearch
                    ?CustomCircularProgressIndicator(isDarkMode: cubit.isDarkMode,)
                    :cubit.searchModel!.isNotEmpty
                        ?buildItems( cubit,size)
                        :const SizedBox()

              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildSearchBar(MainCubit cubit){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cubit.isDarkMode?greyColor:Colors.grey.withOpacity(0.5),
      ),
      child: TextFormField(
        onFieldSubmitted: (key){
          cubit.searchProducts(token: cubit.token, keyWord: key);
        },
          decoration:  InputDecoration(
              border: InputBorder.none,
              prefixIcon: Image.asset(
                  cubit.isDarkMode?CustomIcon.searchDark:CustomIcon.searchLight
              )
          ),
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                color: cubit.isDarkMode?whiteColor:blackColor,
                fontSize: 18.0
            ),
          )
      ),
    );
  }

  Widget buildItems (MainCubit cubit,size){
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            return  InkWell(
              onTap: (){
                print(cubit.searchModel![index].id);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productDetails: cubit.searchModel![index])));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        '${cubit.imagePath}${cubit.searchModel![index].photo}',
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(width: size.width * 0.02,),
                      Expanded(
                        child: CustomText(
                          text: cubit.searchModel![index].name!,
                          color: cubit.isDarkMode ? whiteColor : blackColor,
                          maxLine: 2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Container(

              color: cubit.isDarkMode?primeColorDark:greyColor2,
              height: 3,
            ),
          ),
          itemCount: cubit.searchModel!.length),
    );
  }
}
