import 'dart:developer';
import '../../business_logic/bloc_exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../shared/constants/default_values.dart';
import '../../shared/services/locator.dart';

// Note that .connect() should not be called if autoConnect: true

class SocketHelper {
  static late IO.Socket socket;

  // static List<MessageModel> listMsg = [];

  static void initSocket({required String chatRoom}) {
    //Important: If your server is running on localhost and you are testing your app on Android
    // then replace http://localhost:3000 with http://10.0.2.2:3000
    // Dart client
    socket = IO.io('http://192.168.1.12:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect(); // connect frontend to backend
    log('Connecting to the socket...');

    // Listening
    socket.onConnect((_) {
      log('Connected to frontend!!');

      joinChatRoom(chatRoom);
      log('receive_message receive_message');
      // ====================================
      log('receive_message 1========================');
      receiveMessage();
      receiveUpdatedMessage();
      receiveDeletedMessage();
      log('receive_message 2========================');
    });

    socket.onConnectError((data) => log('Connect Error: $data'));
    socket.onDisconnect((data) => log('Socket.IO server disconnected'));
  }

  // ================================================

  static void joinChatRoom(String chatRoom) {
    socket.emit('join', chatRoom);
  }

  // ================================================

  static void receiveMessage() {
    socket.on('receive_message', (json) {
      // log(name: 'Receive', json.toString());
      if (json['author'] != userEmail) {
        locator<ChatRoomCubit>().receiveMessageSocket(json);
      }
    });
  }

  static void sendMessage(Map<String, dynamic> json) {
    socket.emit('send_message', json);
  }

  // ================================================

  static void receiveUpdatedMessage() {
    socket.on('after_update', (json) {
      log(name: 'Update', 'after_update');
      locator<ChatRoomCubit>().receiveUpdatedMessageSocket(json);
    });
  }

  static void sendUpdatedMessage(Map<String, dynamic> json) {
    socket.emit('update_message', json);
  }

  // ================================================

  static void receiveDeletedMessage() {
    socket.on('after_delete', (json) {
      locator<ChatRoomCubit>().receiveDeletedMessageSocket(json);
    });
  }

  static void sendDeletedMessage(Map<String, dynamic> json) {
    socket.emit('delete_message', json);
  }

  static void closeSocket() {
    socket.dispose();
    socket.destroy();
    socket.close();
    socket.disconnect();
  }
}
