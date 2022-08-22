import 'dart:developer';

import '../../shared/constants/default_values.dart';
import 'package:flutter/foundation.dart';

import '../../network/end_points.dart';
import '../../network/models/user_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../ui/screens/calls/calls_screen.dart';
import '../../ui/screens/people/people_screen.dart';
import '../../ui/screens/profile/profile_screen.dart';
import '../../ui/widgets/all_chats_body.dart';
import '../bloc_exports.dart';

part 'all_chats_state.dart';

class AllChatsCubit extends Cubit<AllChatsState> {
  AllChatsCubit() : super(AllChatsInitialState());

  // Create an object from cubit
  static AllChatsCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  void getUsersAPI() {
    DioHelper.postData(
      url: getUsersEndpoint,
      data: {
        'email': userEmail, // 'ali@gmail.com'
      },
    ).then((value) {
      emit(AllChatsLoadingState());

      log('getUsersAPI Success=${value.data.toString()}');
      // userChatModel = UserChatModel.fromJson(value.data);

      for (var element in value.data) {
        users.add(UserModel.fromJson(element));
      }

      emit(AllChatsSuccessState());
    }).catchError((error) {
      log('getUsersAPI Error=${error.toString()}');

      emit(AllChatsErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  Map<String, dynamic> pages = {
    'title': [
      'Chats',
      'People',
      'Calls',
      'Profile',
    ],
    'screens': [
      const AllChatsBody(),
      const PeopleScreen(),
      const CallsScreen(),
      const ProfileScreen(),
    ],
  };

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AllChatsChangeBottomNavState());
  }
}
