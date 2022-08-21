part of 'all_chats_cubit.dart';

@immutable
abstract class AllChatsState {}

class AllChatsInitialState extends AllChatsState {}

class AllChatsLoadingState extends AllChatsState {}

class AllChatsSuccessState extends AllChatsState {}

class AllChatsErrorState extends AllChatsState {
  final String error;

  AllChatsErrorState(this.error);
}

// ================================================

class AllChatsChangeBottomNavState extends AllChatsState {}
