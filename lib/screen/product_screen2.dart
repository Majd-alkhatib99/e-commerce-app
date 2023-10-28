import 'package:ecommerce/model/products_category_model.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/screen/product_details_screen.dart';
import 'package:ecommerce/screen/product_details_screen2.dart';
import '../shared/style/color.dart';
import 'package:ecommerce/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/main/main_cubit.dart';
import '../shared/components/icons.dart';

class ProductsScreen2 extends StatelessWidget {

  final String title;
  final List<ProductsDataModel> products;
  const ProductsScreen2({
    Key? key,
    this.title='Products',
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=MainCubit.get(context);
        return Scaffold(
          backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: cubit.isDarkMode?secondColorDark:secondColorLight,
            elevation: 0,
            title: Row(
              children: [
                InkWell(
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
                SizedBox(width: size.width*0.3,),
                CustomText(
                  text: title,
                  color: cubit.isDarkMode?whiteColor:blackColor,
                  isBold: true,
                  fontSize: 20.0,
                ),
              ],
            ),



          ),
          body: state is LoadingGetProductsCat
              ?Center(child: CircularProgressIndicator(
            color: cubit.isDarkMode
                ?primeColorDark
                :primeColorLight,
          ),)
              :buildGridView(cubit,products,context),
        );
      },
    );
  }

  Widget buildGridView(MainCubit cubit,List<ProductsDataModel> products,context){
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      childAspectRatio: 1 / 1.60,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
          products.length,
              (index) {
            return  buildItem(cubit, products, index, context);

          }),

    );
  }
  Widget buildItem(MainCubit cubit,List<ProductsDataModel> products,int index,context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
      child: InkWell(
        onTap: (){

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>ProductDetailsScreen2(
                      productDetails: products[index]
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: cubit.isDarkMode? greyColor:Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: MediaQuery.of(context).size.width * .4,
          child: Column(
            children: [
              Container(
                height: 220,
                width:double.infinity,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image:  DecorationImage(
                      image: NetworkImage(cubit.imagePath+products[index].photo!,),
                      fit: BoxFit.fitWidth,
                    )
                ),

              ),
              const SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  text: products[index].name!,
                  alignment: Alignment.bottomLeft,
                  color: cubit.isDarkMode? whiteColor:blackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  text: "${products[index].price}\$",
                  color: cubit.isDarkMode? primeColorDark:primeColorLight,
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
