import 'package:flutter/material.dart';
import '../../../business_logic/bloc_exports.dart';
import '../../../shared/components/methods/all_chats_method.dart';
import '../../../shared/styles/my_colors.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllChatsCubit, AllChatsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AllChatsCubit cubit = AllChatsCubit.get(context);

        return Scaffold(
          appBar: allChatsAppBar(
              appBarTitle: cubit.pages['title'][cubit.currentIndex]),
          body: cubit.pages['screens'][cubit.currentIndex],
          floatingActionButton: cubit.currentIndex < 2
              ? FloatingActionButton(
                  backgroundColor: MyColors.myPrimaryColor,
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              : Container(),
          bottomNavigationBar: allChatsBottomNavigationBar(cubit),
        );
      },
    );
  }
}
