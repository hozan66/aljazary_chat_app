part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final SignInModel signInModel;

  SignInSuccessState(this.signInModel);
}

class SignInErrorState extends SignInState {
  final String error;

  SignInErrorState(this.error);
}

// ===========================================

class SignInChangePasswordVisibilityState extends SignInState {}
