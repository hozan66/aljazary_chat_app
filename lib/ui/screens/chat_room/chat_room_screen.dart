import 'dart:developer';

import '../../widgets/default_loading_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../business_logic/bloc_exports.dart';
import '../../../network/remote/socket_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/methods/chat_room_app_bar.dart';
import '../../../shared/constants/default_values.dart';
import '../../widgets/message.dart';
import '../../widgets/my_input_field.dart';

class ChatRoomScreen extends StatefulWidget {
  final String roomChat;
  final String sender;
  final String receiver;

  const ChatRoomScreen({
    Key? key,
    required this.roomChat,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void initState() {
    super.initState();

    ChatRoomCubit chatCubit = ChatRoomCubit.get(context);
    chatCubit.getChatsAPI(roomChat: widget.roomChat);

    log(name: 'initState', 'initState');
    SocketHelper.initSocket(chatRoom: widget.roomChat);
  }

  // dispose() Called when leaving the screen
  @override
  void dispose() {
    super.dispose();

    SocketHelper.closeSocket();
    log('Socket is Force Disconnect');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatRoomCubit, ChatRoomState>(
      listener: (context, state) {
        if (state is CreateChatRoomSuccessState) {
          showToast(
            text: state.response,
            state: ToastStates.success,
          );
        }
      },
      builder: (context, state) {
        log(name: 'UI', 'My UI');
        // ChatRoomCubit cubit = ChatRoomCubit.get(context);
        return Scaffold(
          appBar: chatRoomAppBar(receiver: widget.receiver),
          body: ConditionalBuilder(
            // condition: state.chatList.isNotEmpty,
            condition: state is! ChatRoomLoadingState,
            // condition: true,
            builder: (context) => Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: myDefaultPadding,
                    ),
                    child: ListView.builder(
                      reverse: true,
                      // When scrolling down the keyboard will close automatically
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.chatList.length,
                      itemBuilder: (context, index) {
                        return Message(
                          model: state.chatList.reversed.toList()[index],
                          sender: widget.sender,
                        );
                      },
                    ),
                  ),
                ),
                MyInputField(
                  roomChat: widget.roomChat,
                  sender: widget.sender,
                  receiver: widget.receiver,
                ),
              ],
            ),
            fallback: (context) => const DefaultLoadingIndicator(),
          ),
        );
      },
    );
  }
}
