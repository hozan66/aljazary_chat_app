import 'dart:developer';

import 'package:flutter/material.dart';

import '../../business_logic/chat_room_cubit/chat_room_cubit.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';

class MyInputField extends StatelessWidget {
  final String roomChat;
  final String sender;
  final String receiver;

  MyInputField({
    Key? key,
    required this.roomChat,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 4.0),
            blurRadius: 32.0,
            color: const Color(0xFF087949).withOpacity(0.2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(
              Icons.mic,
              color: MyColors.myPrimaryColor,
            ),
            const SizedBox(width: myDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: myDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: MyColors.myPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.64),
                    ),
                    const SizedBox(width: myDefaultPadding / 4),
                    IconButton(
                      onPressed: () {
                        String message = _messageController.text.trim();
                        if (message.isNotEmpty) {
                          log('My message=>$message');

                          ChatRoomCubit cubit = ChatRoomCubit.get(context);
                          cubit.sendMessageSocket(
                            roomChat: roomChat,
                            sender: sender,
                            receiver: receiver,
                            message: message,
                          );
                          // _messageController.clear();
                          // _messageController.text = '';
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: MyColors.myPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
