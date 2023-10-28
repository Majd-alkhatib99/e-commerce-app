part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitialState extends AuthState {}

class ShowPasswordState extends AuthState {}

class LoadingLoginState extends AuthState {}
class SuccessLoginState extends AuthState {

}
class ErrorLoginState extends AuthState {
  final String error;
  ErrorLoginState(this.error);
}

class LoadingRegisterState extends AuthState {}
class SuccessRegisterState extends AuthState {


}
class ErrorRegisterState extends AuthState {
  final String error;
  ErrorRegisterState(this.error);
}


