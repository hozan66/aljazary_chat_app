import 'dart:developer';

import 'package:flutter/material.dart';

import '../../network/end_points.dart';
import '../../network/models/sign_in_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/components/components.dart';
import '../bloc_exports.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitialState());

  // Create an object from cubit
  static SignInCubit get(context) => BlocProvider.of(context);

  // All logic in cubit
  late SignInModel signInModel;

  void userSignIn({
    required String email,
    required String password,
  }) {
    emit(SignInLoadingState());

    DioHelper.postData(
      url: signInEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      log('SignIn=${value.data.toString()}');

      var response = value.data;
      if (response is String) {
        showToast(
          text: response,
          state: ToastStates.error,
        );
        emit(SignInErrorState(response));
      } else {
        signInModel = SignInModel.fromJson(value.data);

        emit(SignInSuccessState(signInModel));
      }
    }).catchError((error) {
      log('Error SignIn=${error.toString()}');

      emit(SignInErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SignInChangePasswordVisibilityState());
  }
}
