import 'package:ecommerce/cubit/main/main_cubit.dart';
import 'package:ecommerce/screen/product_details_screen.dart';
import 'package:ecommerce/screen/product_details_screen2.dart';
import 'package:ecommerce/screen/product_screen2.dart';
import 'package:ecommerce/screen/products_screen.dart';
import 'package:ecommerce/screen/search_screen.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/components/constans.dart';
import '../shared/components/icons.dart';
import '../shared/style/color.dart';


class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  HomeScreen({Key? key,this.isDarkMode=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return cubit.productsDataModel!=null
            ?SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
                    cubit.searchModel!.clear();
                  },
                    child: searchTextFormField(cubit.isDarkMode)),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: "Categories",
                  color: cubit.isDarkMode?whiteColor:blackColor,
                  isBold: true,
                  fontSize: 18.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                listOfCategory(cubit.isDarkMode,cubit),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    CustomText(
                      text: "Products",
                      color: cubit.isDarkMode?whiteColor:blackColor,
                      isBold: true,
                      fontSize: 18.0,

                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>ProductsScreen2(
                                products: cubit.productsDataModel!,
                                title: 'All Products',
                              ),));
                      },
                      child: CustomText(
                        text: "See all",
                        color: cubit.isDarkMode?primeColorDark:primeColorLight,
                        isUnderLine: true,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                listOfProducts(cubit.isDarkMode,cubit),
              ],
            ),
          ),
        )
            :Center(child: CircularProgressIndicator(
          color: cubit.isDarkMode
              ?primeColorDark
              :primeColorLight,
        ),);
      }
    );
  }

  Widget searchTextFormField(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark?greyColor:Colors.grey.withOpacity(0.5),
      ),
      child: TextFormField(
        enabled: false,
        decoration:  InputDecoration(
          border: InputBorder.none,
          prefixIcon: Image.asset(
            isDark?CustomIcon.searchDark:CustomIcon.searchLight
          )
        ),
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: isDark?whiteColor:blackColor,
              fontSize: 18.0
          ),
        )
      ),
    );
  }

  final List<String> categoryDark=[
    CustomIcon.menDark,
    CustomIcon.womenDark,
    CustomIcon.bagDark,
    CustomIcon.jewelDark,
    CustomIcon.watchDark,
    CustomIcon.bootDark,
  ];
  final List<String> categoryLight=[
    CustomIcon.menLight,
    CustomIcon.womenLight,
    CustomIcon.bagLight,
    CustomIcon.jewelLight,
    CustomIcon.watchLight,
    CustomIcon.bootLight,
  ];
  final List<String> categoryTitle=[
    'Men',
    'Women',
    'Bag',
    'Jewel',
    'Watch',
    'Shoes',
  ];
  Widget listOfCategory(bool isDark,MainCubit cubit) {
    // String token=CacheHelper.getData(key: 'token');
    return SizedBox(
      height: 100.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

                cubit.getProductsByCat(token:cubit.token,index:index+1);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>ProductsScreen(
                        products: cubit.productsCatDataModel!,
                        title: categoryTitle[index],
                      ),));
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isDark?greyColor:Colors.grey.withOpacity(0.5),
                    ),
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                          isDark?categoryDark[index]:categoryLight[index],


                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: categoryTitle[index],
                    color: isDark?whiteColor:blackColor,
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 20.0,),
          itemCount: categoryDark.length),
    );
  }

  Widget listOfProducts(bool isDark,MainCubit cubit){
    return SizedBox(
      height: 280.0,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen2(productDetails: cubit.productsDataModel![index])));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isDark? greyColor:Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                        ),
                        image:  DecorationImage(
                            image: NetworkImage(
                              '${cubit.imagePath}${cubit.productsDataModel![index].photo}',
                                ),
                          fit: BoxFit.cover,
                        )
                      ),

                    ),
                    const SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: cubit.productsDataModel![index].name!,
                        alignment: Alignment.bottomLeft,
                        color: isDark? whiteColor:blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: "${cubit.productsDataModel![index].price!}\$",
                        color: isDark? primeColorDark:primeColorLight,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context,index)=>const SizedBox(width: 20.0,),
          itemCount: 3),
    );
  }
}
