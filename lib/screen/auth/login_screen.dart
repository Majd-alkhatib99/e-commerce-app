import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:ecommerce/cubit/register%20and%20login/auth_cubit.dart';
import 'package:ecommerce/screen/auth/register_screen.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widget/custom_button_social.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_form_field.dart';
import '../control_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state is SuccessLoginState){
          CacheHelper.saveData(key: 'isLogin', value: true).then((value){
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
        var cubit = AuthCubit.get(context);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor:cubit.isDarkMode? secondColorDark:secondColorLight,
            appBar: AppBar(
              backgroundColor: cubit.isDarkMode? secondColorDark:secondColorLight,
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness:cubit.isDarkMode?Brightness.light:Brightness.dark,
                statusBarColor: cubit.isDarkMode?secondColorDark:secondColorLight,
                statusBarIconBrightness: cubit.isDarkMode?Brightness.light:Brightness.dark,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
              ),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           CustomText(
                            color: cubit.isDarkMode
                                ?whiteColor
                                :blackColor,
                            text: "Welcome,",
                            fontSize: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  const RegisterScreen(),));
                            },
                            child:  CustomText(
                              text: "Sign Up",
                              isBold: true,
                              color: cubit.isDarkMode
                                  ?primeColorDark
                                  :primeColorLight,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomText(
                        text: 'Sign in to Continue',
                        fontSize: 14,
                        color: greyColor,
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
                        textEditingController: cubit.emailController,
                        onSave: (value) {
                          //controller.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleas enter your Email';
                          }
                          if(value.contains('@')==false|| value.contains('.') == false){
                            return 'Please enter a valid Email';
                          }
                          return null;
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
                        textEditingController: cubit.passwordController,
                        obscureText: cubit.isShowPassword,
                        icon: IconButton(
                          icon:  Icon(
                            cubit.passwordIcon,
                            color: cubit.isShowPassword
                                ?Colors.grey
                                :cubit.isDarkMode?primeColorDark:primeColorLight,
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
                        height: 20,
                      ),
                       CustomText(
                        text: 'Forgot Password?',
                         isBold: true,
                        color: cubit.isDarkMode
                            ?primeColorDark
                            :primeColorLight,
                        fontSize: 14,
                        alignment: Alignment.topRight,
                      ),
                      const SizedBox(
                        height: 15,
                      ),


                      ProgressButton(
                        stateWidgets:  {
                           ButtonState.idle: CustomText(
                             alignment: Alignment.center,
                           text: "Login",
                            color: cubit.isDarkMode?blackColor:whiteColor,
                           ),
                          ButtonState.loading: CustomText(
                            alignment: Alignment.center,
                            text: "Loading",
                            color: cubit.isDarkMode?blackColor:whiteColor,
                          ),
                          ButtonState.fail: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                alignment: Alignment.center,
                                text: "Fail",
                                color: whiteColor,
                              ),
                               SizedBox(width:5.0 ),
                               Icon(
                                Icons.error_outline,
                                color: whiteColor,
                              )
                            ],


                          ),
                          ButtonState.success:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                alignment: Alignment.center,
                                text: "Success",
                                color: cubit.isDarkMode?blackColor:whiteColor,
                              ),
                              const SizedBox(width:5.0 ),
                              Icon(
                                Icons.check_circle,
                                color: cubit.isDarkMode?primeColorDark:primeColorLight,
                              )
                            ],
                          )
                        },
                        progressIndicatorAlignment: MainAxisAlignment.spaceAround,
                        progressIndicatorSize: 30,
                        height: 40,
                        progressIndicator:   CircularProgressIndicator(
                          backgroundColor:cubit.isDarkMode?primeColorDark:primeColorLight,
                          valueColor:  AlwaysStoppedAnimation(cubit.isDarkMode?secondColorDark:secondColorLight), strokeWidth: 2, ),
                        stateColors: {
                          ButtonState.idle: cubit.isDarkMode?primeColorDark:primeColorLight,
                          ButtonState.loading:cubit.isDarkMode?primeColorDark:primeColorLight,
                          ButtonState.fail: Colors.red.shade300,
                          ButtonState.success: secondColorLight,
                        },
                        // maxWidth: double.infinity,
                        // minWidth: 50,
                        onPressed: (){
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.loginUser(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                              );
                            }
                            cubit.emailController.clear();
                            cubit.passwordController.clear();
                        },
                        state: cubit.loginState,
                        padding: const EdgeInsets.all(8.0),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                       CustomText(
                        text: '-OR-',
                        color: cubit.isDarkMode
                            ?whiteColor
                            :blackColor,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButtonSocial(
                        text: 'Sign In with Facebook',
                        onPress: () {
                          //controller.facebookSignInMethod();
                        },
                        imageName: 'assets/icons/facebook.png',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButtonSocial(
                        text: 'Sign In with Google',
                        onPress: () {
                          //controller.googleSignInMethod();
                        },
                        imageName: 'assets/icons/google.png',
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

  Widget buildTextWithIconWithMinState(state,cubit) {



    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Send",
            icon: const Icon(Icons.send, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading:
        IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: const Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: ()=> cubit.login(),
      state: cubit.loginState,
      minWidthStates: const [ButtonState.loading],
      height: 50.0 ,
      // maxWidth: double.infinity,
      // minWidth: 20,
    );
  }

}