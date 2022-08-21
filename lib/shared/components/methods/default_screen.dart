import 'dart:developer';
import 'package:flutter/widgets.dart';
import '../../../network/local/cache_helper.dart';
import '../../../ui/screens/all_chats/all_chats_screen.dart';
import '../../../ui/screens/sign_in_and_sign_up/sign_in_and_sign_up_screen.dart';
import '../../../ui/screens/welcome/welcome_screen.dart';
import '../../constants/default_values.dart';

Widget defaultScreen() {
  bool? isWelcomeScreen = CacheHelper.getData(key: 'welcomeScreen');
  log('isWelcomeScreen=$isWelcomeScreen');
  Widget? widget;
  token = CacheHelper.getData(key: 'token');
  log('token=$token');

  if (isWelcomeScreen != null) {
    if (token != null) {
      widget = const AllChatsScreen();
    } else {
      widget = const SignInAndSignUpScreen();
    }
  } else {
    widget = const WelcomeScreen();
  }
  return widget;
}
