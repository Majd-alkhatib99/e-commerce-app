
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/register and login/auth_cubit.dart';
import '../../shared/components/icons.dart';
import '../../widget/custom_buttom.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_form_field.dart';
import '../control_screen.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SuccessRegisterState){
          CacheHelper.saveData(key: 'isLogin', value: true).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context)=> const ControlScreen(),),
                    (Route<dynamic> route) => false
            );
          });

        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor:cubit.isDarkMode? secondColorDark:secondColorLight,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness:cubit.isDarkMode?Brightness.light:Brightness.dark,
                statusBarColor: cubit.isDarkMode?secondColorDark:secondColorLight,
                statusBarIconBrightness: cubit.isDarkMode?Brightness.light:Brightness.dark,
              ),
              backgroundColor: cubit.isDarkMode? secondColorDark:secondColorLight,
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
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomText(
                        color: cubit.isDarkMode
                            ? whiteColor
                            : blackColor,
                        text: "Sing up",
                        fontSize: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        textColor: cubit.isDarkMode
                            ?whiteColor
                            :blackColor,
                        color: cubit.isDarkMode
                            ?greyColor
                            :greyColor2,
                        primeColor: cubit.isDarkMode
                            ?primeColorDark
                            :primeColorLight,
                        text: 'Name',
                        hint: 'Majd',
                        textEditingController: cubit.nameRegisterController,
                        textInputType: TextInputType.text,
                        onSave: (value) {
                          //controller.name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter your name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        textColor: cubit.isDarkMode
                            ?whiteColor
                            :blackColor,
                        color: cubit.isDarkMode
                            ?greyColor
                            :greyColor2,
                        primeColor: cubit.isDarkMode
                            ?primeColorDark
                            :primeColorLight,
                        text: 'Phone',
                        hint: '+963999999999',
                        textInputType: TextInputType.phone,
                        textEditingController: cubit.phoneRegisterController,
                        onSave: (value) {
                          //controller.name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter your phone number';
                          }
                          if(value.length<10){
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        textColor: cubit.isDarkMode
                            ?whiteColor
                            :blackColor,
                        color: cubit.isDarkMode
                            ?greyColor
                            :greyColor2,
                        primeColor: cubit.isDarkMode
                            ?primeColorDark
                            :primeColorLight,
                        text: 'Email',
                        hint: 'Example@gmail.com',
                        textInputType: TextInputType.emailAddress,
                        textEditingController: cubit.emailRegisterController,
                        onSave: (value) {

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter your Email';
                          }

                          if(value.contains('@')==false|| value.contains('.') == false){
                            return 'Please enter a valid Email';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        textColor: cubit.isDarkMode
                            ?whiteColor
                            :blackColor,
                        color: cubit.isDarkMode
                            ?greyColor
                            :greyColor2,
                        primeColor: cubit.isDarkMode
                            ?primeColorDark
                            :primeColorLight,
                        text: 'Password',
                        hint: '**********',
                        textInputType: TextInputType.visiblePassword,

                        textEditingController: cubit.passwordRegisterController,
                        obscureText: true,
                        icon: IconButton(
                          icon: Icon(
                            cubit.passwordIcon,
                            color: cubit.isShowPassword
                                ? Colors.grey
                                : cubit.isDarkMode
                                ? primeColorDark
                                : primeColorLight,
                          ),
                          onPressed: () {
                            cubit.showPassword();
                          },
                        ),
                        onSave: (value) {
                          //controller.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter your password';
                          }
                          if(value.length<8){
                            return 'Please enter at least 8 characters';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                     state is LoadingRegisterState
                         ?  Center(child: CircularProgressIndicator(
                       color: cubit.isDarkMode
                           ?primeColorDark
                           :primeColorLight,
                     ),)
                         : CustomButton(
                       textColor: cubit.isDarkMode
                           ?secondColorDark
                           :secondColorLight,
                       color: cubit.isDarkMode
                           ?primeColorDark
                           :primeColorLight,
                       onPress: () {


                         if (formKey.currentState!.validate()) {
                           cubit.registerUser(
                               name: cubit.nameRegisterController.text,
                               email: cubit.emailRegisterController.text,
                               password: cubit.passwordRegisterController.text);
                           // Navigator.pushAndRemoveUntil(
                           //     context,
                           //     MaterialPageRoute(
                           //       builder: (context)=>const ControlScreen(),),
                           //         (Route<dynamic> route) => false
                           //
                           // );
                         }
                       },
                       text: 'SIGN Up',
                     ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}