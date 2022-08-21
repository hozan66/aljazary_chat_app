part of 'chat_room_cubit.dart';

@immutable
abstract class ChatRoomState extends Equatable {
  final List<UserChatDataModel> chatList;

  const ChatRoomState({this.chatList = const []});

  @override
  List<Object?> get props => [chatList];
}

class ChatRoomInitialState extends ChatRoomState {
  // @override
  // List<Object?> get props => [];
}

class ChatRoomLoadingState extends ChatRoomState {
  // @override
  // List<Object?> get props => [];
}

class ChatRoomSuccessState extends ChatRoomState {
  const ChatRoomSuccessState({required List<UserChatDataModel> chatList})
      : super(chatList: chatList);

  // @override
  // List<Object?> get props => [chatList];
}

class ChatRoomErrorState extends ChatRoomState {
  final String error;

  const ChatRoomErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// ================================================

class CreateChatRoomSuccessState extends ChatRoomState {
  final String response;

  const CreateChatRoomSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateChatRoomErrorState extends ChatRoomState {
  final String error;

  const CreateChatRoomErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// ================================================

// class SendChatSuccessState extends ChatRoomState {
//   const SendChatSuccessState({required List<UserChatDataModel> chatList})
//       : super(chatList: chatList);
//
//   // @override
//   // List<Object?> get props => [];
// }

class SendChatErrorState extends ChatRoomState {
  final String error;

  const SendChatErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// ================================================

class UpdateMessageErrorState extends ChatRoomState {
  final String error;

  const UpdateMessageErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// ================================================

class DeleteMessageErrorState extends ChatRoomState {
  final String error;

  const DeleteMessageErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
