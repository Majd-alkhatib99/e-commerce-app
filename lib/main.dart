import 'package:ecommerce/cubit/register%20and%20login/auth_cubit.dart';
import 'package:ecommerce/screen/auth/login_screen.dart';
import 'package:ecommerce/screen/control_screen.dart';
import 'package:ecommerce/screen/settings_screen.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:ecommerce/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/blocObserver.dart';
import 'cubit/main/main_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool isLogin = CacheHelper.getData(key: 'isLogin')??false;
    final String token = CacheHelper.getData(key: 'token')??'';
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(),),
        BlocProvider<MainCubit>(create: (context) => MainCubit()..getUserInfo(token: token)..getAllProducts(token: token),),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            home: isLogin?const ControlScreen():const LoginScreen(),
          );
        },

      ),
    );
  }
}

