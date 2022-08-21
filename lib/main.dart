import 'network/local/cache_helper.dart';
import 'shared/components/methods/default_screen.dart';
import 'shared/services/locator.dart';
import 'shared/styles/my_theme.dart';
import 'package:flutter/material.dart';
import 'business_logic/bloc_exports.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Global access
      providers: [
        BlocProvider(
          create: (BuildContext context) => AllChatsCubit()..getUsersAPI(),
        ),
        BlocProvider(
          create: (BuildContext context) => locator<ChatRoomCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter aljazary Chat App',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightThemeData(context),
        darkTheme: MyTheme.darkThemeData(context),
        home: defaultScreen(),
      ),
    );
  }
}
