part of 'main_cubit.dart';

abstract class MainState {}

class MainInitialState extends MainState {}

class ChangeModeState extends MainState {}
class ChangeNavIndexState extends MainState {}

class AddAmountState extends MainState {}
class SubAmountState extends MainState {}

class LoadingGetUserInfo extends MainState{}
class SuccessGetUserInfo extends MainState{}
class ErrorGetUserInfo extends MainState{}

class LoadingGetAllProducts extends MainState{}
class SuccessGetAllProducts extends MainState{}
class ErrorGetAllProducts extends MainState{}

class LoadingGetProductsCat extends MainState{}
class SuccessGetProductsCat extends MainState{}
class ErrorGetProductsCat extends MainState{}

class LoadingGetCart extends MainState{}
class SuccessGetCart extends MainState{}
class ErrorGetCart extends MainState{}

class LoadingRemoveProductFromCart extends MainState{}
class SuccessRemoveProductFromCart extends MainState{}
class ErrorRemoveProductFromCart extends MainState{}

class LoadingAddProductToCart extends MainState{}
class SuccessAddProductToCart extends MainState{}
class ErrorAddProductToCart extends MainState{}

class LoadingGetFav extends MainState{}
class SuccessGetFav extends MainState{}
class ErrorGetFav extends MainState{}

class LoadingRemoveProductFromFav extends MainState{}
class SuccessRemoveProductFromFav extends MainState{}
class ErrorRemoveProductFromFav extends MainState{}

class LoadingAddProductToFav extends MainState{}
class SuccessAddProductToFav extends MainState{}
class ErrorAddProductToFav extends MainState{}

class LoadingSearch extends MainState{}
class SuccessSearch extends MainState{}
class ErrorSearch extends MainState{}

class LoadingAddOrder extends MainState{}
class SuccessAddOrder extends MainState{}
class ErrorAddOrder extends MainState{}

class LoadingLogOut extends MainState{}
class SuccessLogOut extends MainState{}
class ErrorLogOut extends MainState{}