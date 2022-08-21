import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../business_logic/bloc_exports.dart';
import '../../../network/models/user_chat_model.dart';

class EditMessageScreen extends StatelessWidget {
  final UserChatDataModel model;

  EditMessageScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    messageController.text = model.message;
    messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length));
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Edit Message',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextField(
              autofocus: true,
              controller: messageController,
              decoration: const InputDecoration(
                label: Text('Edit'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  String editMessage = messageController.text.trim();
                  if (editMessage.isNotEmpty) {
                    log('My Edited message=>$editMessage');

                    ChatRoomCubit cubit = ChatRoomCubit.get(context);
                    cubit.sendUpdatedMessageSocket(
                      roomChat: model.room,
                      updatedMessage: editMessage,
                      id: model.id,
                    );
                  }

                  Navigator.pop(context);
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
