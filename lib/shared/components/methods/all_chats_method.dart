import 'package:flutter/material.dart';

import '../../../business_logic/all_chats_cubit/all_chats_cubit.dart';

AppBar allChatsAppBar({required String appBarTitle}) {
  return AppBar(
    // Remove back button
    automaticallyImplyLeading: false,
    title: Text(appBarTitle),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    ],
  );
}

BottomNavigationBar allChatsBottomNavigationBar(AllChatsCubit cubit) {
  return BottomNavigationBar(
    currentIndex: cubit.currentIndex,
    type: BottomNavigationBarType.fixed,
    onTap: (value) {
      cubit.changeBottomNav(value);
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chats'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
      BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
      BottomNavigationBarItem(
        icon: CircleAvatar(
          radius: 14.0,
          backgroundImage: AssetImage('assets/images/user_2.png'),
        ),
        label: 'Profile',
      ),
    ],
  );
}
