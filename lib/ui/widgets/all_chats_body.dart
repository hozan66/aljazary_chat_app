import 'dart:developer';

import 'chat_card.dart';
import 'default_loading_indicator.dart';
import 'filled_outline_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../business_logic/bloc_exports.dart';
import '../../network/models/chat_model.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/default_values.dart';
import '../../shared/styles/my_colors.dart';
import '../screens/chat_room/chat_room_screen.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllChatsCubit, AllChatsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AllChatsCubit cubit = AllChatsCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context) => Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                  myDefaultPadding,
                  0.0,
                  myDefaultPadding,
                  myDefaultPadding,
                ),
                color: MyColors.myPrimaryColor,
                child: Row(
                  children: [
                    FillOutlineButton(
                      press: () {},
                      text: 'Recent Message',
                    ),
                    const SizedBox(width: myDefaultPadding),
                    FillOutlineButton(
                      press: () {},
                      text: 'Active',
                      isFilled: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.users.length,
                  itemBuilder: (context, index) {
                    ChatModel chat = ChatModel(
                      name: cubit.users[index].email,
                      lastMessage: cubit.users[index].email,
                      image: "assets/images/welcome_image.png",
                      time: "3m ago",
                      isActive: false,
                    );

                    return ChatCard(
                      chat: chat,
                      press: () {
                        // ==================
                        List<String> roomChatNames = [
                          userEmail ?? 'userEmail',
                          cubit.users[index].email
                        ];
                        roomChatNames.sort();

                        String roomChatName = roomChatNames.join('--with--');
                        log(roomChatName);

                        // ==================
                        navigateTo(
                            context,
                            ChatRoomScreen(
                              roomChat: roomChatName,
                              sender: userEmail ?? 'userEmail', //userEmail,
                              receiver: cubit.users[index].email,
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          fallback: (context) => const DefaultLoadingIndicator(),
        );
      },
    );
  }
}
