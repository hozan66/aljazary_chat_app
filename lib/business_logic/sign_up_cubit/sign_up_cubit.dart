import 'dart:developer';
import 'package:flutter/material.dart';
import '../../network/end_points.dart';
import '../../network/models/sign_up_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/components/components.dart';
import '../bloc_exports.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  // Create an object from cubit
  static SignUpCubit get(context) => BlocProvider.of(context);

  // All logic in cubit
  late SignUpModel signUpModel;
  void userSignUp({
    required String email,
    required String password,
  }) {
    emit(SignUpLoadingState());

    DioHelper.postData(
      url: signUpEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      log('SignUp: ${value.data.toString()}');

      var response = value.data;
      if (response is String) {
        showToast(
          text: response,
          state: ToastStates.error,
        );

        emit(SignUpErrorState(response));
      } else {
        signUpModel = SignUpModel.fromJson(value.data);

        emit(SignUpSuccessState(signUpModel));
      }
    }).catchError((error) {
      log('Error SignUp=${error.toString()}');

      emit(SignUpErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SignUpChangePasswordVisibilityState());
  }
}
