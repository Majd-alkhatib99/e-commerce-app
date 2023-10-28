
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/network/end_point.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../model/user_model.dart';
import '../../shared/network/local/cache_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameRegisterController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController = TextEditingController();
  final TextEditingController phoneRegisterController = TextEditingController();


  bool isShowPassword = true;
  IconData passwordIcon= Icons.visibility_outlined;
  void showPassword(){
    isShowPassword = !isShowPassword;
    isShowPassword? passwordIcon=Icons.visibility_outlined: passwordIcon=Icons.visibility_off_outlined;
    emit(ShowPasswordState());
  }

  bool isDarkMode = CacheHelper.getData(key: 'isDark')?? true;

  String? token;

  ButtonState loginState=ButtonState.idle;
  void loginUser ({
    required String? email,
    required String? password,
  }){

    isState('LoadingLoginState');
    emit(LoadingLoginState());

    DioHelper.postData(

        url: EndPoint.login,
        data: {
      'email':email,
      'password':password
    }).then((value) {


      CacheHelper.saveData(key: 'token',value: value.data['token']);
      if(value.data==null){
        loginState=isState('ErrorLoginState');
        emit(ErrorLoginState('Error'));
      }else{
        loginState=isState('SuccessLoginState');
        emit(SuccessLoginState());
      }


    }).catchError((error){
      loginState=isState('ErrorLoginState');
      emit(ErrorLoginState(error));

    });
  }


  ButtonState isState(String state) {

    switch(state){
      case 'LoadingLoginState':{
        loginState = ButtonState.loading;

        break;
      }
      case 'SuccessLoginState':
        {
          loginState = ButtonState.success;

          break;
        }
      case 'ErrorLoginState':
        {
          loginState = ButtonState.fail;

          break;
        }
    }
    return loginState;
  }

  void registerUser({
        required String? name,
        required String? email,
        required String? password,
      }
      ){
    emit(LoadingRegisterState());
    DioHelper.postData(
        url: EndPoint.register,
        data: {
          'name':name,
          'email':email,
          'password':password
        }).then((value) {
          print(value.data);
          CacheHelper.saveData(key: 'token',value: value.data['token']);
          emit(SuccessRegisterState());
    }).catchError((error){
      print(error);
      print(error);
      emit(ErrorRegisterState(error.toString()));
    });
  }

}
