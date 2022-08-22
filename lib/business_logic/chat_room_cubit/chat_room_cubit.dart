import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../network/end_points.dart';
import '../../network/models/user_chat_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/socket_helper.dart';
import '../../shared/constants/default_values.dart';
import '../bloc_exports.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitialState());

  // Create an object from cubit
  static ChatRoomCubit get(context) => BlocProvider.of(context);

  // Get Data
  List<UserChatDataModel> newChatList = [];
  Future<void> getChatsAPI({required String roomChat}) async {
    DioHelper.getData(
      url: '$getChatsEndpoint/$roomChat',
    ).then((value) {
      emit(ChatRoomLoadingState());

      // List<UserChatDataModel> newChatList = [];

      // log('getChatsAPI Success=${value.data.toString()}');
      var response = value.data;
      if (response is String) {
        createChatRoomAPI(roomChat: roomChat);
      } else {
        for (var element in value.data) {
          for (var element2 in element['data']) {
            newChatList.add(UserChatDataModel.fromJson(element2));
          }
        }

        emit(ChatRoomSuccessState(chatList: newChatList));
      }
    }).catchError((error) {
      log('getChatsAPI Error=${error.toString()}');

      emit(ChatRoomErrorState(error.toString()));
    });
  }

  // Create Chat Room
  void createChatRoomAPI({
    required String roomChat,
  }) {
    // emit(ChatRoomLoadingState());
    DioHelper.postData(
      url: newConversationEndpoint,
      data: {
        'room': roomChat,
        'data': [],
      },
    ).then((value) {
      log('createChatRoomAPI=${value.data.toString()}');

      emit(CreateChatRoomSuccessState(value.data.toString()));
      // emit(const ChatRoomSuccessState(chatList: []));
    }).catchError((error) {
      log('createChatRoomAPI Error=${error.toString()}');

      emit(CreateChatRoomErrorState(error.toString()));
    });
  }

  // Send Data
  Future<String?> sendMessageAPI({
    required String roomChat,
    required String sender,
    required String receiver,
    required String message,
  }) async {
    try {
      var messageList = await DioHelper.postData(
        url: sendChatEndpoint,
        data: {
          'room': roomChat,
          'data': {
            'room': roomChat,
            'author': sender,
            'message': message,
            'messageType': 'message',
            'see': [sender, receiver],
            'time': '12:16',
          },
        },
      );

      String lastMessageID = messageList.data['data'].last['_id'];
      return lastMessageID;
    } catch (error) {
      log('sendMessageAPI Error=${error.toString()}');
      emit(SendChatErrorState(error.toString()));
    }

    return null;
  }

  void sendMessageSocket({
    required String roomChat,
    required String sender,
    required String receiver,
    required String message,
  }) async {
    String? lastMessageID = await sendMessageAPI(
      roomChat: roomChat,
      sender: sender,
      receiver: receiver,
      message: message,
    );

    log('After lastMessageID=$lastMessageID');

    log('=========================================');
    Map<String, dynamic> json = {
      'room': roomChat,
      'author': sender,
      'message': message,
      'messageType': 'message',
      'see': [sender, receiver],
      'time': '12:16',
      '_id': lastMessageID,
    };

    SocketHelper.sendMessage(json);
    log('sendMessageSocket');
    final state = this.state;
    List<UserChatDataModel> newChatList = state.chatList;
    UserChatDataModel model = UserChatDataModel.fromJson(json);

    newChatList = List.from(newChatList)..add(model);
    log(name: 'Send length', '${newChatList.length}');

    emit(ChatRoomSuccessState(chatList: newChatList));
    log('=========================================');
  }

  void receiveMessageSocket(Map<String, dynamic> json) {
    try {
      log('=>=>=>receiveMessageSocket=>=>=>=>=>');
      // log(json.toString());
      if (json['author'] != userEmail) {
        final state = this.state;
        List<UserChatDataModel> newChatList = state.chatList;

        UserChatDataModel model = UserChatDataModel.fromJson(json);
        newChatList = List.from(newChatList)..add(model);
        log(name: 'Receive length', '${newChatList.length}');

        emit(ChatRoomSuccessState(chatList: newChatList));
        log('chatList=${newChatList.last.message}');

        log('receiveMessageSocket');
        log(newChatList.length.toString());
      }
    } catch (e) {
      log('Receive from socket Error=${e.toString()}');
    }
  }

  // =========================================

  // Update Data
  Future<void> updateMessageAPI(Map<String, dynamic> json) async {
    try {
      await DioHelper.putData(
        url: updatedMessageEndpoint,
        data: json,
      );

      log('updateMessageAPI');
    } catch (error) {
      log('updateMessageAPI Error=${error.toString()}');
      emit(UpdateMessageErrorState(error.toString()));
    }
  }

  Future<void> sendUpdatedMessageSocket({
    required String roomChat,
    required String updatedMessage,
    required String id,
  }) async {
    final state = this.state;
    List<UserChatDataModel> oldChatList = state.chatList;
    List<UserChatDataModel> newChatList = [];

    List<Map<String, dynamic>> chatListJson;
    chatListJson = oldChatList.map((model) {
      if (model.id == id) {
        newChatList.add(model);
        return model.copyWith(message: updatedMessage).toJson();
        // log(model.message);
      }
      newChatList.add(model);

      return model.toJson();
    }).toList();

    Map<String, dynamic> json = {
      'room': roomChat,
      'data': chatListJson,
    };

    await updateMessageAPI(json);

    Map<String, dynamic> jsonSocket = {
      'room': roomChat,
      'messageList': chatListJson,
    };

    SocketHelper.sendUpdatedMessage(jsonSocket);
    log('sendUpdatedMessageSocket');

    emit(ChatRoomSuccessState(chatList: newChatList));
    log('=========================================');
  }

  void receiveUpdatedMessageSocket(List<dynamic> jsonList) {
    try {
      log('=>=>=>receiveUpdatedMessageSocket=>=>=>=>=>');
      log(jsonList.toString());

      List<UserChatDataModel> newChatList = [];
      for (var element in jsonList) {
        newChatList.add(UserChatDataModel.fromJson(element));
      }

      // final state = this.state;
      // List<UserChatDataModel> newChatList = state.chatList;

      emit(ChatRoomSuccessState(chatList: newChatList));
      log('=>=>=>receiveUpdatedMessageSocket=>=>=>=>=>');
    } catch (e) {
      log('receiveUpdatedMessageSocket Error=${e.toString()}');
    }
  }

  // =============================================
  // Delete Data
  Future<void> deleteMessageAPI({
    required String roomChat,
    required String id,
  }) async {
    try {
      await DioHelper.postData(
        url: '$deleteForEveryOneEndpoint/$id',
        data: {
          'room': roomChat,
        },
      );
      log('deleteMessageAPI');
    } catch (error) {
      log('deleteMessageAPI Error=${error.toString()}');
      emit(DeleteMessageErrorState(error.toString()));
    }
  }

  sendDeletedMessageSocket({
    required String roomChat,
    required String id,
  }) async {
    await deleteMessageAPI(
      roomChat: roomChat,
      id: id,
    );

    final state = this.state;
    List<UserChatDataModel> oldChatList = state.chatList;
    List<UserChatDataModel> newChatList = [];

    for (var model in oldChatList) {
      if (model.id == id) {
        continue;
      }
      newChatList.add(model);
    }

    Map<String, dynamic> json = {
      'room': roomChat,
      // 'data': chatListJson,
    };

    SocketHelper.sendDeletedMessage(json);
    log('sendDeletedMessageSocket');

    emit(ChatRoomSuccessState(chatList: newChatList));
    log('=========================================');
  }

  void receiveDeletedMessageSocket(Map<String, dynamic> json) async {
    try {
      log('=>=>=>receiveDeletedMessageSocket=>=>=>=>=>');
      await getChatsAPI(roomChat: json['room']);

      emit(ChatRoomSuccessState(chatList: newChatList));
    } catch (e) {
      log('receiveDeletedMessageSocket Error=${e.toString()}');
    }
  }
}
