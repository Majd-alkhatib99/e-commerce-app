import 'package:ecommerce/screen/auth/login_screen.dart';
import 'package:ecommerce/screen/cart_screen.dart';
import 'package:ecommerce/screen/favorite_screen.dart';
import 'package:ecommerce/screen/home_screeen.dart';
import 'package:ecommerce/shared/network/end_point.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/products_category_model.dart';
import '../../model/products_model.dart';
import '../../model/user_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  String token = CacheHelper.getData(key: 'token')??'';
  bool isDarkMode = CacheHelper.getData(key: 'isDark')??true;
  String imagePath ='http://192.168.43.142:8000/images/products/';

  void convertMode(){
    isDarkMode = !isDarkMode;
    CacheHelper.saveData(key: 'isDark', value: isDarkMode).then((value) {
      emit(ChangeModeState());
    });

  }
  int navIndex =0;
  List<Widget> screens = [
    HomeScreen(),
    const CartScreen(),
    const FavoriteScreen()
  ];
  List<String> appBarTitle=[
    'Home',
    'Cart List',
    'Wish List'
  ];
  void changeNavIndex(int index){
    navIndex = index;
    if(index==1) getCart(token: token);
    if(index==2) getFav(token: token);
    emit(ChangeNavIndexState());
  }
  int amount=1;
  void addAmount(){
    if(amount>=1)amount++;
    emit(AddAmountState());
  }
  void subAmount(){
    if(amount>1)amount--;
    emit(SubAmountState());
  }

  UserModel? userModel;
  void getUserInfo({
    required String token
  }){
    emit(LoadingGetUserInfo());
    String token1=CacheHelper.getData(key: 'token');
    DioHelper.getData(
        url: EndPoint.getUserInfo,
        token: token1
    ).then((value) {
      userModel=UserModel.fromJson(value.data['user']);
      emit(SuccessGetUserInfo());
    }).catchError((error){
      print(error);
      emit(ErrorGetUserInfo());
    });
  }


  List<ProductsDataModel>? productsDataModel;
  void getAllProducts({required String token}){
    emit(LoadingGetAllProducts());
    String token1=CacheHelper.getData(key: 'token');
    DioHelper.getData(
        url: EndPoint.getAllProducts,
        token: token1)
        .then((value) {
          if (value.data['data'] != null) {
            productsDataModel =[];
            value.data['data'].forEach((v) {
              productsDataModel!.add( ProductsDataModel.fromJson(v));
            });
          }
          emit(SuccessGetAllProducts());
    }).catchError((error){
      print(error);
      emit(ErrorGetAllProducts());
    });

  }


  List<ProductsCategoryDataModel>? productsCatDataModel;
  void getProductsByCat({required String token,required int index}){
    emit(LoadingGetProductsCat());
    productsCatDataModel = [];
    DioHelper.getData(
        url: '${EndPoint.getProductsByCat}/$index',
        token: token)
        .then((value) {
          if (value.data['data'] != null) {
            value.data['data'].forEach((element) {
              productsCatDataModel!.add(ProductsCategoryDataModel.fromJson(element));
            });

          }
          emit(SuccessGetProductsCat());
    })
        .catchError((error){
          print(error);
          emit(ErrorGetProductsCat());
    });
  }

  List<ProductsCategoryDataModel>? cartModel=[];
  void getCart({required String token}){
    emit(LoadingGetCart());
    cartModel!.clear();

    DioHelper.getData(
        url: EndPoint.getCart,
        token: token)
        .then((value) {

      if (value.data['data'] != null) {
        value.data['data'].forEach((element) {
          cartModel!.add(ProductsCategoryDataModel.fromJson(element));
        });

      }
      emit(SuccessGetCart());
    })
        .catchError((error){
      emit(ErrorGetCart());
    });
  }
  void addProductToCart({required String token,required int id}){
    emit(LoadingAddProductToCart());

    DioHelper.getData(
        url: '${EndPoint.addProductToCart}/$id',
        token: token)
        .then((value) {
      emit(SuccessAddProductToCart());
    })
        .catchError((error){
      emit(ErrorAddProductToCart());
    });
  }
  void removeProductFromCart({required String token,required int id}){
    emit(LoadingRemoveProductFromCart());

    DioHelper.getData(
        url: '${EndPoint.removeProductFromCart}/$id',
        token: token)
        .then((value) {
          getCart(token: token);
          emit(SuccessRemoveProductFromCart());
    })
        .catchError((error){
      emit(ErrorRemoveProductFromCart());
    });
  }

  List<ProductsCategoryDataModel>? favModel=[];
  void getFav({required String token}){
    emit(LoadingGetFav());
    favModel!.clear();
    DioHelper.getData(
        url: EndPoint.getFav,
        token: token)
        .then((value) {
      if (value.data['data'] != null) {
        value.data['data'].forEach((element) {
          favModel!.add(ProductsCategoryDataModel.fromJson(element));
        });


      }
      emit(SuccessGetFav());
    })
        .catchError((error){
      emit(ErrorGetFav());
    });
  }
  void addProductToFav({required String token,required int id}){
    emit(LoadingAddProductToFav());

    DioHelper.getData(
        url: '${EndPoint.addProductToFav}/$id',
        token: token)
        .then((value) {
      print(value.data);
      emit(SuccessAddProductToFav());
    })
        .catchError((error){
      emit(ErrorAddProductToFav());
    });
  }
  void removeProductFromFav({required String token,required int id}){
    emit(LoadingRemoveProductFromFav());

    DioHelper.getData(
        url: '${EndPoint.removeProductFromFav}/$id',
        token: token)
        .then((value) {
      getFav(token: token);
      emit(SuccessRemoveProductFromFav());
    })
        .catchError((error){
      emit(ErrorRemoveProductFromFav());
    });
  }

  List<ProductsCategoryDataModel>? searchModel=[];
  void searchProducts({required String token,required String keyWord}){
    emit(LoadingSearch());
    searchModel!.clear();
     DioHelper.postData(
       token: token,
         url: EndPoint.search,
         data: {
           'keyword': keyWord
         })
         .then((value) {
       if (value.data['data'] != null) {
         value.data['data'].forEach((element) {
           searchModel!.add(ProductsCategoryDataModel.fromJson(element));
         });
       }
           emit(SuccessSearch());
     })
         .catchError((error){
           print(error);
           emit(ErrorSearch());
     });
  }

  void addOrder({required String token}){
    emit(LoadingAddOrder());
    DioHelper.postData(
        url: EndPoint.addOrder,
        data: {

        },
      token: token,
    )
        .then((value) {
      emit(SuccessAddOrder());
    })
        .catchError((error){
      emit(ErrorAddOrder());
    });
  }
  void logOut(context,String token){
    emit(LoadingLogOut());
    DioHelper.postData(
        token: token,
        url: EndPoint.logOut,
        data:{}).then((value) {
          CacheHelper.removeData(key: 'isLogin');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context)=> const LoginScreen(),),
                  (Route<dynamic> route) => false
          );
          emit(SuccessLogOut());
        }).catchError((error){
          emit(ErrorLogOut());
    });

  }
}
