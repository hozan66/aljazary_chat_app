part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final SignUpModel signUpModel;

  SignUpSuccessState(this.signUpModel);
}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState(this.error);
}

// ================================================

class SignUpChangePasswordVisibilityState extends SignUpState {}
