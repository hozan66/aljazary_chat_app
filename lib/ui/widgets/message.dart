import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../../business_logic/chat_room_cubit/chat_room_cubit.dart';
import '../../network/models/user_chat_model.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';
import '../screens/edit_message/edit_message_screen.dart';

class Message extends StatelessWidget {
  final UserChatDataModel model;
  final String sender;

  const Message({
    Key? key,
    required this.model,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: myDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: model.sender == sender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (model.sender != sender) ...[
            // Used to add list to the current list
            const CircleAvatar(
              radius: 12.0,
              backgroundImage: AssetImage('assets/images/welcome_image.png'),
            ),
            const SizedBox(width: myDefaultPadding / 2),
          ],
          textMessage(
            context: context,
            model: model,
            sender: sender,
          ),
        ],
      ),
    );
  }
}

void editMessage({
  required BuildContext context,
  required UserChatDataModel model,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // So keyboard won't cover showModalBottomSheet
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding:
            // viewInsets is for the keyboard
            // viewInsets represents areas fully obscured by the system
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Builder(builder: (context) {
          return EditMessageScreen(
            model: model,
          );
        }),
      ),
    ),
  );
}

Widget textMessage({
  required BuildContext context,
  required UserChatDataModel model,
  required String sender,
}) {
  return Flexible(
    child: Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      child: model.sender == sender
          ? FocusedMenuHolder(
              openWithTap: true,
              // false for long press
              onPressed: () {},
              menuWidth: 150.0,
              blurBackgroundColor: Colors.white,
              blurSize: 0.0,
              menuItems: [
                FocusedMenuItem(
                  title: const Text('Edit'),
                  trailingIcon: const Icon(Icons.edit),
                  onPressed: () {
                    log('Edit');
                    editMessage(
                      context: context,
                      model: model,
                    );
                  },
                ),
                FocusedMenuItem(
                  title: const Text(
                    'Delete for all',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailingIcon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  backgroundColor: MyColors.myErrorColor,
                  onPressed: () {
                    ChatRoomCubit cubit = ChatRoomCubit.get(context);
                    cubit.sendDeletedMessageSocket(
                      roomChat: model.room,
                      id: model.id,
                    );
                  },
                ),
              ],
              child: DefaultContainer(
                model: model,
                sender: sender,
              ),
            )
          : DefaultContainer(
              model: model,
              sender: sender,
            ),
    ),
  );
}

class DefaultContainer extends StatelessWidget {
  final UserChatDataModel model;
  final String sender;

  const DefaultContainer({
    Key? key,
    required this.model,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.75,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: MyColors.myPrimaryColor
            .withOpacity(model.sender == sender ? 1.0 : 0.08),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        model.message,
        style: TextStyle(
          color: model.sender == sender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}
