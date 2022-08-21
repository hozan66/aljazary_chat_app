import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar defaultAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
    ),
  );
}
